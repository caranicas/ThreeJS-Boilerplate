
View =  require './view.coffee'
Backbone   = require 'backbone'
Backbone.$ = require 'jquery'
Router =  require './router.coffee'

basicDemo = require './demo.coffee'
physiDemo = require './physidemo.coffee'
shaderDemo = require './shaderdemo.coffee'



class App

  constructor: ->
    @router = new Router()
    @router.on 'route:index', @appIndex
    @router.on 'route:physics', @physIndex
    @router.on 'route:shader', @shaderIndex
    Backbone.history.start()


  appIndex: ->
    view = new View(el: '#canvas-layer', demo:basicDemo)
  physIndex: ->
    view = new View(el: '#canvas-layer', demo:physiDemo)
  shaderIndex: ->
    view = new View(el: '#canvas-layer', demo:shaderDemo)


app = new App()
