Backbone   = require 'backbone'
Demos = require './demos'

AppRouter = Backbone.Router.extend

  constructor: ->
    @demos = new Demos()
    @__createRoutes()
    @

  __createRoutes:->
    @route("", "index")
    for link in @demos.get 'data'
      @route("!"+link.url, link.name)

module.exports = AppRouter
