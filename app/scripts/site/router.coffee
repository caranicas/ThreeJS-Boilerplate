Backbone   = require 'backbone'

AppRouter = Backbone.Router.extend

  routes:
    "":"index"
    "#!/phys":"goPhysics"

  index: () ->
    alert('index')

  goPhysics:->
    alert('phsy')



module.exports = AppRouter







#exports.AppRouter = class AppRouter extends Backbone.Router
