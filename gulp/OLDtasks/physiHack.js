var gulp       = require('gulp');
var imagemin   = require('gulp-imagemin');
var config     = require('../config').physimove;

gulp.task('physi-hack', function() {
  return  gulp.src(config.src)
    .pipe(gulp.dest(config.dest));
});
