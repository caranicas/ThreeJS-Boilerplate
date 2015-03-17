var gulp = require('gulp');
var server = require('gulp-express');

gulp.task('server', function () {
    //start the server at the beginning of the task
    console.log('RUN IT');
    return server.run({
        file: './build/server.js'
    });
});
