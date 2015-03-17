var gulp = require('gulp');
var browserify = require('browserify');
//var reactify = require('reactify');
//var literalify = require('literalify');


gulp.task('browserify',function () {
  b = browserify({
    debug: true,
    extensions: ['.js', '.json'],
    //transform: [reactify, literalify.configure({react: 'window.React'})]
  });

  b.add('./temp/app.js');
  b.bundle().pipe(require('fs').createWriteStream('./build/scripts/appbundle.js'));

});
