##View =  require './view.coffee'
##view = new View(el: '#canvas-layer')
Backbone   = require 'backbone'
jquery = require 'jquery'
Router =  require './router.coffee'


class App

  constructor: ->
    Backbone.$ = jquery
    @router = new Router()
    Backbone.history.start()
    #router = new Router()
    @router.on 'index', @appIndex

  appIndex: ->
    alert('appp')



app = new App()
