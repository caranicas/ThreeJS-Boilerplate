
View =  require './view.coffee'
Backbone   = require 'backbone'
Backbone.$ = require 'jquery'
Router =  require './router.coffee'

basicDemo = require './demos/basicdemo.coffee'
physiDemo = require './demos/physidemo.coffee'
shaderDemo = require './demos/shaderdemo.coffee'
goblinDemo = require './demos/goblindemo.coffee'

class App

  isDebugging:true

  constructor: ->
    @router = new Router()
    @router.on 'route:index', @appIndex
    @router.on 'route:physics', @physIndex
    @router.on 'route:shader', @shaderIndex
    @router.on 'route:goblin', @gobinIndex
    test = Backbone.history.start({ pushState: true})

  appIndex: =>
    view = new View(el: '#canvas-layer', demo:new basicDemo({debug:@isDebugging}))
  physIndex: =>
    view = new View(el: '#canvas-layer', demo:new physiDemo({debug:@isDebugging}))
  shaderIndex: =>
    view = new View(el: '#canvas-layer', demo:new shaderDemo({debug:@isDebugging}))
  gobinIndex: =>
    view = new View(el: '#canvas-layer', demo:new goblinDemo({debug:@isDebugging}))


app = new App()
