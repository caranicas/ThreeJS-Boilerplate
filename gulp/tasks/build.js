var gulp = require('gulp');

gulp.task('build', ['browserify','bowerfiles', 'stylus', 'images', 'markup']);
