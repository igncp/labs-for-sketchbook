module.exports = (config)->
  config.set({
    basePath: ''
    
    frameworks: [
      'chai'
      'mocha'
    ]

    files: [
      './ramda/ramda.js'
      './tests/**/*.coffee'
      './tests/**/*.js'
    ]

    preprocessors:
      './tests/**/*.coffee': ['coffee']
      './tests/**/*.js': ['babel']

    coffeePreprocessor:
      options:
        bare: true,
        sourceMap: false
      transformPath: (path)-> path.replace(/\.coffee$/, '.js')
    
    babelPreprocessor:
      options:
        sourceMap: 'inline'
      filename: (file)-> file.originalPath.replace(/\.js$/, '.es5.js')
      sourceFileName: (file)-> file.originalPath

    reporters: ['progress']
    port: 9876
    colors: true
    logLevel: config.LOG_ERROR
    browsers: ['Chrome']
    singleRun: false
  })