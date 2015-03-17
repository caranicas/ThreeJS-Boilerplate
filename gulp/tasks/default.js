var gulp = require('gulp');
var gulpsync = require('gulp-sync')(gulp);


gulp.task('setup',['makedir']);
gulp.task('build',['compile','stylus']);
gulp.task('move', ['browserify','statics']);
gulp.task('serve',['server'/*, 'clean'*/]);
gulp.task('default', gulpsync.sync(['setup','build', 'move', 'serve'], 'default task'));
