
Backbone   = require 'backbone'
$ = Backbone.$ = require 'jquery'
Router =  require './router'

MenuView = require './pages/view'
GlView =  require './gl/view'

Demos = require './appDemos'

class App

  isDebugging:true

  constructor: ->
    @demos = new Demos()
    @router = new Router(model:@demos)
    console.log '@router', @router
    @__routeHandlers()
    @__facitatePushState()
    Backbone.history.start({ pushState: @demos.get('isPushState')})

  __routeHandlers: ->
    @router.on 'route:index', @appIndex
    for route in @demos.get 'data'
      routeName = 'route:'+ route.name
      @router.on routeName, @__demoRouteFunction(route.demoClass)

  appIndex: =>
    IntroView = new MenuView(el: 'body', model:@demos)

  __demoRouteFunction:(demoClass) =>
    =>
      View = new GlView(el: 'body', demo:new demoClass({debug:@demos.get('isDebugging')}))


  __facitatePushState: ->
    if @demos.get('isPushState')
      $(document).on 'click', 'a:not([data-bypass])', (evt) =>
        console.log 'EVT', evt
        href = $(evt).attr('href')
        console.log 'HREF', href
        protocol = @protocol + '//'
        if href.slice(protocol.length) != protocol
          evt.preventDefault()
          console.log '@router', @router
          @router.navigate href, true


app = new App()
