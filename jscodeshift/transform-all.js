// This script is intended to be run through babel.
// Run:
//  - make transform-all
//  - babel-node transform-all.js
// At your convenience

var promisify = require("promisify-node");
var R = require('ramda');
var q = require('q');
var exec = promisify(require('child_process').exec);
var wrench = require('wrench');
var fs = require('fs');

var readdir = promisify(fs.readdir);
var mkdir = promisify(fs.mkdir);

var getTransformersFullNames = () => readdir('./es6/transformers');
var getSourcesDirsNames = () => readdir('./es6/source-examples');
var getJSFilenames = R.map(fullFilename => fullFilename.slice(0, -3));
var createDirs = R.map((filename) => mkdir('./dist/' + filename));
var saveTransformersNames = _transformersNames => transformersNames = _transformersNames;

var transformersNames;

console.log('Starting...');
console.log('');

mkdir('./dist')
  .then(getTransformersFullNames)
  .then(getJSFilenames)
  .then(saveTransformersNames)
  .then((transformers) => q.all(createDirs(transformers)))
  .then(getSourcesDirsNames)
  .then((sourcesDirsNames) => {
    return q.all(R.map(function(transformerName) {
      return q.all(R.map(function(sourcesDirName) {
        var defer = q.defer();
        wrench.copyDirRecursive('./es6/source-examples/' + sourcesDirName,
          './dist/' + transformerName + '/' + sourcesDirName, defer.resolve);
        return defer.promise;
      })(sourcesDirsNames));
    })(transformersNames));
  })
  .then(function() {
    return q.all(R.map(function(transformerName) {
      return exec('./repositories/jscodeshift/bin/jscodeshift.sh -t ./es6/transformers/' + transformerName + '.js dist/' + transformerName + '/**/*.js')
        .then(function(stdout) {
          console.log(stdout.trim());
          console.log('----');
          console.log('');
        });
    })(transformersNames));
  })
  .then(function() {
    console.log("Finished");
  })
  .catch(function(e) {
    console.log("e", e);
  });
