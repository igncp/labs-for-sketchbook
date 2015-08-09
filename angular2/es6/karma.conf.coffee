module.exports = (config)->
  config.set({
    basePath: '',
    frameworks: [
      'jasmine'
      'jspm'
      'chai'
    ],
    jspm: {
      config: 'jspm-config.js'
      loadFiles: [
        'reflect-import.js'
        'tests/_common.js'
        'tests/**/*.test.js'
      ]
    },
    plugins:[
      'karma-mocha'
      'karma-chai'
      'karma-jspm'
      'karma-jasmine'
      'karma-chrome-launcher'
    ],
    reporters: ['progress'],
    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,
    autoWatch: false,
    browsers: ['Chrome'],
    singleRun: true
  })