
Backbone   = require 'backbone'
Backbone.$ = require 'jquery'
Router =  require './router.coffee'


MenuView = require './pages/view.coffee'

GlView =  require './gl/view.coffee'
basicDemo = require './gl/demos/basicdemo.coffee'
physiDemo = require './gl/demos/physidemo.coffee'
shaderDemo = require './gl/demos/shaderdemo.coffee'
goblinDemo = require './gl/demos/goblindemo.coffee'

class App

  isDebugging:true

  constructor: ->
    @router = new Router()

    console.log 'ROUTER', @router

    @router.on 'route:index', @appIndex
    @router.on 'route:basic', @basicIndex
    @router.on 'route:physics', @physIndex
    @router.on 'route:shader', @shaderIndex
    @router.on 'route:goblin', @gobinIndex

    Backbone.history.start()

  appIndex: =>
    alert 'APPP INDEX'
    IntroView = new MenuView(el: 'body')

  basicIndex: =>
    BacisView = new GlView(el: 'body', demo:new basicDemo({debug:@isDebugging}))
  physIndex: =>
    PhysView = new GlView(el: 'body', demo:new physiDemo({debug:@isDebugging}))
  shaderIndex: =>
    ShaderView = new GlView(el: 'body', demo:new shaderDemo({debug:@isDebugging}))
  gobinIndex: =>
    GoblinView = new GlView(el: 'body', demo:new goblinDemo({debug:@isDebugging}))


app = new App()
