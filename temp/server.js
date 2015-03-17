var app, demoRequest, express, homeRequest, scriptIncludes, styleIncludes;

express = require('express');

app = express();

app.get('/', function(req, res) {
  return homeRequest(res);
});

app.get('/basic', function(req, res) {
  return demoRequest(res);
});

app.get('/shader', function(req, res) {
  return demoRequest(res);
});

app.get('/physics', function(req, res) {
  return demoRequest(res);
});

app.get('/goblin', function(req, res) {
  return demoRequest(res);
});

app.use("/scripts", express["static"]('./build/scripts'));

app.use("/styles", express["static"]('./build/styles'));

app.use("/textures", express["static"]('./build/textures'));

app.listen(3000);

homeRequest = function(res) {
  var styles;
  console.log('home request');
  res.setHeader('Content-Type', 'text/html');
  styles = styleIncludes();
  return res.end(styles + '<div id=content>' + 'HOME PAGE' + '</div>' + scriptIncludes());
};

demoRequest = function(res) {
  var styles;
  console.log('DEMO request');
  res.setHeader('Content-Type', 'text/html');
  styles = styleIncludes();
  return res.end(styles + '<div id=content>' + 'DEMO PAGE' + '</div>' + scriptIncludes());
};

styleIncludes = function() {
  return '<link rel="stylesheet" href="styles/index.css"/>';
};

scriptIncludes = function() {
  return '<script src=//code.jquery.com/jquery-2.1.1.min.js></script>' + '<script src=/scripts/appbundle.js></script>';
};
