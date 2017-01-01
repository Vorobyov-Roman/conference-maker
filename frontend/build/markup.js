'use strict'

var config     = require('../config/gulp').markup;
var gulp       = require('gulp');
var jade       = require('gulp-jade');
var notify     = require('gulp-notify');
var glob       = require('glob');

function getScriptsPaths() {
  var options = {
    cwd:    'src',
    dot:    false,
    nosort: true
  }

  var scripts = [
    'vendor/jquery.js',
    'vendor/bootstrap.js',
    'vendor/angular.js',
    'vendor/angular-route.js',
    'vendor/angular-cookies.js',
    'vendor/angular-animate.js',
    'vendor/ui-bootstrap-tpls.js'
  ]

  return scripts
    .concat(glob.sync('scripts/utility/**/*.js',     options))
    .concat(glob.sync('scripts/backend/**/*.js',     options))
    .concat(glob.sync('scripts/input_utils/**/*.js', options))
    .concat(glob.sync('scripts/main/**/*.js',        options))
    .concat(glob.sync('scripts/*.js',                options));
}

function getStylesPaths() {
  return [
    'vendor/bootstrap.css',
    'styles/styles.css'
  ]
}

exports.build = function() {
  var locals = {
    deps: {
      scripts: getScriptsPaths(),
      styles:  getStylesPaths()
    }
  }

  return gulp
    .src(config.source)
    .pipe(jade({
      pretty: true,
      locals: locals
    }))
    .pipe(gulp.dest(config.destination))
    .pipe(notify({
      onLast: true,
      message: config.message
    }));
}
