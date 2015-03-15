
Backbone   = require 'backbone'
Backbone.$ = require 'jquery'
Router =  require './router'

MenuView = require './pages/view'
GlView =  require './gl/view'

Demos = require './appDemos'

class App

  isDebugging:true

  constructor: ->
    @demos = new Demos()
    @router = new Router(@demos)
    @__routeHandlers()
    Backbone.history.start({ pushState: @demos.get('isPushState')})

  __routeHandlers: ->
    @router.on 'route:index', @appIndex
    for route in @demos.get 'data'
      routeName = 'route:'+ route.name
      @router.on routeName, @__demoRouteFunction(route.demoClass)

  appIndex: =>
    IntroView = new MenuView(el: 'body')

  __demoRouteFunction:(demoClass) =>
    =>
      View = new GlView(el: 'body', demo:new demoClass({debug:@demos.get('isDebugging')}))

app = new App()
