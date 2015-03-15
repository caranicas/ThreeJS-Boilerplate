Backbone   = require 'backbone'
Demos = require './pages/demos.coffee'

AppRouter = Backbone.Router.extend

  test:[1,2,3]
  constructor: ->
    @demos = new Demos()
    @__createRoutes()
    @

  __createRoutes:->
    @route("", "index")
    for link in @demos.get 'links'
      @route("!"+link.url, link.name)

module.exports = AppRouter
