Backbone   = require 'backbone'

AppRouter = Backbone.Router.extend

  # constructor:(args) ->
  #   super
  #   console.log 'router con'

  routes:
    "":"index"
    "/physics":"physics"
    "/shader":"shader"
    "/goblin":"goblin"

module.exports = AppRouter
