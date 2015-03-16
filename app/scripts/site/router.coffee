Backbone   = require 'backbone'

$ = require 'jquery'

class AppRouter extends Backbone.Router

  constructor:(options) ->
    super
    @model = options.model
    @__createRoutes()
    @

  __createRoutes:->
    @route("", "index")
    bang = ""
    for link in @model.get 'data'
      @route(bang+link.url, link.name)

module.exports = AppRouter
