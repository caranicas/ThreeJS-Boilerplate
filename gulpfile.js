/*
  gulpfile.js
  ===========
  Rather than manage one giant configuration file responsible
  for creating multiple tasks, each task has been broken out into
  its own file in gulp/tasks. Any files in that directory get
  automatically required below.

  To add a new task, simply add a new task file that directory.
  gulp/tasks/default.js specifies the default set of tasks to run
  when you run `gulp`.
*/

var requireDir = require('require-dir');
// Require all tasks in gulp/tasks, including subfolders
requireDir('./gulp/tasks', { recurse: true });





var gulp = require('gulp');
var concat = require('gulp-concat');
var coffee = require('gulp-coffee');
var uglify = require('gulp-uglify');



gulp.task('component', function() {
  gulp.src('app/scripts/site/obj/*.coffee')
    .pipe(coffee({bare: true}))
      .pipe(gulp.dest('comptest/'));
});