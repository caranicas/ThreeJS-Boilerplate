var gulp = require('gulp');
var server = require('gulp-express');

gulp.task('server', function () {
    console.log('RUN IT');
    server.run(['./build/server.js']);
});
