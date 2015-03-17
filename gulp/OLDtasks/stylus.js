var gulp = require('gulp');
var stylus = require('gulp-stylus');
var config= require('../config').stylus;


gulp.task('stylus', function () {
  gulp.src(config.src)
    .pipe(stylus())
    .pipe(gulp.dest(config.dest));
});