var gulp = require('gulp');
var mainBowerFiles = require('main-bower-files');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');

gulp.task('bowerfiles', function() {
  return gulp.src(mainBowerFiles(), { base: './app/scripts/vendor' })
  .pipe(concat('vendor.js'))
  .pipe(uglify())
  .pipe(gulp.dest('build/scripts/vendor'));

});

gulp.task('default', ['bowerfiles']);
