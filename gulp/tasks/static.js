var gulp = require('gulp');

gulp.task('static-server',function () {
  return gulp.src('./temp/server.js')
    .pipe(gulp.dest('./build/'));
});

// gulp.task('static-lib',function () {
//  return gulp.src('./temp/scripts/lib/**/*.js')
//     .pipe(gulp.dest('./build/scripts/lib/'));
// });

gulp.task('static-shared',function () {
  return gulp.src('./temp/scripts/shared/**/*.js')
  .pipe(gulp.dest('./build/scripts/shared/'));
});


gulp.task('static-assets',function () {
  return gulp.src('./src/textures')
  .pipe(gulp.dest('./build'));
});


gulp.task('statics',['static-server', 'static-assets', 'static-shared']);
