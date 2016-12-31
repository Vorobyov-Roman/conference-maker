"use strict"

var config = require('../config/gulp.js').vendor;
var gulp   = require('gulp');
var copy   = require('gulp-copy');
var notify = require('gulp-notify');

exports.build = function() {
  return gulp
    .src(config.source)
    .pipe(copy(config.destination, { prefix: 4 }))
    .pipe(notify({
      onLast: true,
      message: config.message
    }));
}
