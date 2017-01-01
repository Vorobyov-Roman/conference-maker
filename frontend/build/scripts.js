'use strict'

var config = require('../config/gulp').scripts;
var gulp   = require('gulp');
var notify = require('gulp-notify');

exports.build = function() {
  return gulp
    .src(config.source)
    .pipe(gulp.dest(config.destination))
    .pipe(notify({
      onLast: true,
      message: config.message
    }));
}
