var gulp = require('gulp');
var fs = require('fs');

gulp.task('makedir', function () {
  var dirStruct = '/build/scripts';
  var dirs = dirStruct.split('/');
  var newDir = '.';
  for (var i = 0; i < dirs.length; i++) {
    newDir += dirs[i] + '/';
    console.log(newDir);

    if (!fs.exists(newDir)) {
      fs.mkdir(newDir, function(error) {
        console.log(error);
      })
    }
  }
});
