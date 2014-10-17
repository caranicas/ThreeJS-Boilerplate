##View =  require './view.coffee'
##view = new View(el: '#canvas-layer')
Backbone   = require 'backbone'

Router =  require './router.coffee'







class App

  constructor: ->
    @router = new Router()

    #router = new Router()
    console.log('router', @router)

    @router.on 'index', @appIndex

    Backbone.history.start();


  appIndex: ->
    alert('appp')




app = new App()
