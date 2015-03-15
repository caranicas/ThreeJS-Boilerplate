Backbone   = require 'backbone'

MenuView = require './pages/view.coffee'


GlView =  require './gl/view.coffee'
basicDemo = require './gl/demos/basicdemo.coffee'

AppRouter = Backbone.Router.extend

  initalize: ->
    console.log 'router INIT'
    #@__createRoutes()


  __createRoutes:->
    console.log 'CREATE'
    @route("", "index", appIndex)
    @route("!/basic", "basic", basicIndex)
    #@routes[""] = 'index'
    #@routes["!/basic"] = "basic"



  appIndex: =>
    alert 'APP'
    IntroView = new MenuView(el: 'body')

  basicIndex: =>
    BacisView = new GlView(el: 'body', demo:new basicDemo({debug:true}))


  routes:
    ""

module.exports = AppRouter
