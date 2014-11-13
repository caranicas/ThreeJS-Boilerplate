Backbone   = require 'backbone'

AppRouter = Backbone.Router.extend

  routes:
    "":"index"
    "!/physics":"physics"
    "!/shader":"shader"

module.exports = AppRouter
