
express = require 'express'
app = express()
# RouteMod = require('./scripts/shared/appDemos')
# console.log('ROUTE MOD', RouteMod);

#ROUTES
app.get('/', (req, res) ->
  homeRequest res
)

app.get('/basic', (req, res) ->
  demoRequest res
)

app.get('/shader', (req, res) ->
  demoRequest res
)

app.get('/physics', (req, res) ->
  demoRequest res
)

app.get('/goblin', (req, res) ->
  demoRequest res
)

app.use("/scripts", express.static('./build/scripts'))
app.use("/styles", express.static('./build/styles'))
app.use("/textures", express.static('./build/textures'))

#START
app.listen(3000)

#REQUESTS
homeRequest = (res) ->
  console.log 'home request'
  res.setHeader('Content-Type', 'text/html')
  styles = styleIncludes()
  res.end(styles+'<div id=content>'+ 'HOME PAGE'+'</div>'+scriptIncludes())

demoRequest = (res) ->
  console.log 'DEMO request'
  res.setHeader('Content-Type', 'text/html')
  styles = styleIncludes()
  res.end(styles+'<div id=content>'+'DEMO PAGE'+'</div>'+scriptIncludes())

#UTILS
styleIncludes = ->
  return '<link rel="stylesheet" href="styles/index.css"/>'

scriptIncludes = ->
  return '<script src=//code.jquery.com/jquery-2.1.1.min.js></script>'+'<script src=/scripts/appbundle.js></script>'
