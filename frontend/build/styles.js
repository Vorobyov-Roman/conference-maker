"use strict"

var config = require('../config/gulp.js').styles;
var gulp   = require('gulp');
var sass   = require('gulp-sass');
var concat = require('gulp-concat-util');
var notify = require('gulp-notify');

exports.build = function() {
  return gulp
    .src(config.source)
    .pipe(sass().on('error', sass.logError))
    .pipe(concat('styles.css'))
    .pipe(gulp.dest(config.destination))
    .pipe(notify({
      onLast: true,
      message: config.message
    }));
}
