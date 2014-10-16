var gulp = require('gulp');
var config = require('../config').physmove

gulp.task('filemove', function() {
  return gulp.src(config.src)
    .pipe(gulp.dest(config.dest));
});
