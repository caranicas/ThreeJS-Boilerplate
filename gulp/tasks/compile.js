var gulp = require('gulp');
var coffee = require('gulp-coffee');

gulp.task('coffee', function() {
  return gulp.src('./src/**/*.coffee')
    .pipe(coffee({bare: true}))
    .pipe(gulp.dest('./temp'));
});


gulp.task('hbs', function() {
  return gulp.src('./src/**/*.hbs')
    .pipe(gulp.dest('./temp'));
});


gulp.task('compile',['coffee', 'hbs']);
