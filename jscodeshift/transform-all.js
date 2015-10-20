// This script is intended to be run through babel.
// Run:
//  - make transform-all
//  - babel-node transform-all.js
// At your convenience
// It transforms the n(number of source dirs) x m(number of transformers) combinations
// and saves them in `dist`

var promisify = require("promisify-node");
var R = require('ramda');
var q = require('q');
var exec = promisify(require('child_process').exec);
var wrench = require('wrench');
var fs = require('fs');

var readdir = promisify(fs.readdir);
var mkdir = promisify(fs.mkdir);

var qAllMapped = R.curryN(2, R.compose(q.all, R.map));

var getTransformersFullNames = () => readdir('./es6/transformers');
var getSourcesDirsNames = () => readdir('./es6/source-examples');
var getJSFilenames = R.map(fullFilename => fullFilename.slice(0, -3));
var createDirs = R.map((filename) => mkdir('./dist/' + filename));
var saveTransformersNames = _transformersNames => transformersNames = _transformersNames;

var execJSCodeshift = function(transformerName) {
  return exec(
    './repositories/jscodeshift/bin/jscodeshift.sh -t ./es6/transformers/' + transformerName + '.js dist/' + transformerName + '/**/*.js'
  ).then(function(stdout) {
    console.log(stdout.trim());
    console.log('----');
    console.log('');
  });
};

var getCopyDirFn = function(transformerName) {
  return function(sourcesDirName) {
    var defer = q.defer();
    wrench.copyDirRecursive('./es6/source-examples/' + sourcesDirName,
      './dist/' + transformerName + '/' + sourcesDirName, defer.resolve);
    return defer.promise;
  };
};

var transformersNames;

console.log('Starting...');
console.log('');

mkdir('./dist')
  .then(getTransformersFullNames)
  .then(getJSFilenames)
  .then(saveTransformersNames)
  .then((transformers) => q.all(createDirs(transformers)))
  .then(getSourcesDirsNames)
  .then((sourcesDirsNames) => qAllMapped((transformerName) => {
    return qAllMapped(getCopyDirFn(transformerName))(sourcesDirsNames);
  })(transformersNames))
  .then(() => qAllMapped(execJSCodeshift)(transformersNames))
  .then(() => console.log("Finished"))
  .catch(e => console.log("Error: ", e));
