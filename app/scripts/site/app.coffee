Backbone   = require 'backbone'
Backbone.$ = require 'jquery'
Router =  require './router.coffee'


class App

  constructor: ->
    @router = new Router()
    @router.on 'index', @appIndex
    Backbone.history.start()
    #router = new Router()


  appIndex: ->
    alert('appp')



app = new App()
