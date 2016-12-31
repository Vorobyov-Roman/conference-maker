"use strict"

var gulp    = require('gulp');
var watch   = require('gulp-watch');
var del     = require('del');
var scripts = require('./build/scripts');
var styles  = require('./build/styles');
var markup  = require('./build/markup');
var vendor  = require('./build/vendor');
var config  = require('./config/gulp');

gulp.task('vendor',  vendor.build);
gulp.task('styles',  styles.build);
gulp.task('scripts', scripts.build);
gulp.task('markup',  markup.build);

gulp.task('once', ['scripts', 'styles', 'markup']);

gulp.task('default', ['once'], function() {
  watch(config.scripts.watch_source, scripts.build);
  watch(config.styles.watch_source,  styles.build);
  watch(config.markup.watch_source,  markup.build);

  watch(config.scripts.watch_source, { events: ['unlink'] }, function() {
    del.sync(config.scripts.destination);

    return scripts.build().pipe(markup.build());
  });

  watch(config.scripts.watch_source, { events: ['add'] }, function() {
    return scripts.build().pipe(markup.build());
  });
});
