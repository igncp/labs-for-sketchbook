/**
 * Transforms the n(number of source dirs) x m(number of transformers) combinations
 * and saves them in `DIST_DIR`
 *
 * - make transform-all
 * or
 * - babel-node transform-all.js
 */

const promisify = require("promisify-node");
const R = require('ramda');
const q = require('q');
const exec = promisify(require('child_process').exec);
const wrench = require('wrench');
const fs = require('fs');

const TRANSFORMERS_DIR = './es6/transformers/';
const SOURCES_DIR = './es6/source-examples/';
const DIST_DIR = './dist/';
const JSCODESHIFT_DIR = './repositories/jscodeshift/bin/';

var transformersNames;

const promisifySyncFn = (fn) => {
  return () => {
    return new Promise((resolve) => {
      return resolve(fn());
    });
  };
};
const readdir = promisify(fs.readdir);
const mkdir = promisify(fs.mkdir);
const qAllMapped = R.curryN(2, R.compose(q.all, R.map));

const start = () => {
  console.log('Starting');
  console.log('');
};
const createDistDir = () => mkdir(DIST_DIR);
const getTransformersFullNames = () => readdir(TRANSFORMERS_DIR);
const getSourcesDirsNames = () => readdir(SOURCES_DIR);
const getJSFilenames = R.map(fullFilename => fullFilename.slice(0, -3));
const createDistDirs = R.map((filename) => mkdir(DIST_DIR + filename));
const createDistDirsWithTransformers = transformers => q.all(createDistDirs(transformers));
const saveTransformersNames = _transformersNames => transformersNames = _transformersNames;
const getCopyDirFn = (transformerName) => {
  const copyDirRecursive = (sourcesDirName, cb) => {
    wrench.copyDirRecursive(SOURCES_DIR + sourcesDirName,
      DIST_DIR + transformerName + '/' + sourcesDirName, cb);
  };

  return promisify(copyDirRecursive);
};
const copySourcesToDist = (sourcesDirsNames) => {
  return qAllMapped((transformerName) => {
    return qAllMapped(getCopyDirFn(transformerName))(sourcesDirsNames);
  })(transformersNames);
};
const execJSCodeshift = (transformerName) => {
  return exec(
    `${JSCODESHIFT_DIR}jscodeshift.sh -t ${TRANSFORMERS_DIR}${transformerName}.js ${DIST_DIR}${transformerName}/**/*.js`
  ).then((stdout) => {
    console.log(stdout.trim());
    console.log('----');
    console.log('');
  });
};
const transformDistFiles = () => qAllMapped(execJSCodeshift)(transformersNames);
const finish = () => console.log('Finished!');

const startPromisified = promisifySyncFn(start);

startPromisified()
  .then(createDistDir)
  .then(getTransformersFullNames)
  .then(getJSFilenames)
  .then(saveTransformersNames)
  .then(createDistDirsWithTransformers)
  .then(getSourcesDirsNames)
  .then(copySourcesToDist)
  .then(transformDistFiles)
  .then(finish)
  .catch(e => console.log("Error: ", e));
