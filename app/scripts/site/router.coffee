Backbone   = require 'backbone'

AppRouter = Backbone.Router.extend

  routes:
    "":"index"
    "!/physics":"physics"
    "!/shader":"shader"
    "!/goblin":"goblin"

module.exports = AppRouter
