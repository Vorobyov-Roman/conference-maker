'use strict'

var vendorPaths = require('./gulp.js').vendor.source;

module.exports = function(config) {
  config.set({

    basePath: '../',

    frameworks: ['jasmine'],

    files: vendorPaths.angular.concat([
      'node_modules/angular-mocks/angular-mocks.js',

      'src/scripts/**/module.js',
      'src/scripts/**/*.js',
      'src/scripts/*.js',

      'test/unit/**/*.spec.coffee'
    ]),

    exclude: [
    ],

    preprocessors: {
      'test/unit/**/*.spec.coffee': ['coffee'],
    },

    coffeePreprocessor: {
      options: {
        bare: true,
        sourceMap: false
      },
      transformPath: function(path) {
        return path.replace(/\.coffee$/, '.js')
      }
    },

    reporters: ['progress', 'kjhtml'],

    port: 9876,

    colors: true,

    logLevel: config.LOG_INFO,

    autoWatch: true,

    browsers: [],

    singleRun: false,

    concurrency: Infinity

  });
}
