'use strict'

var config = require('../config/gulp').vendor;
var gulp   = require('gulp');
var copy   = require('gulp-copy');
var notify = require('gulp-notify');

exports.build = function() {
  return gulp
    .src(config.source.all)
    .pipe(copy(config.destination, { prefix: 4 }));
}
