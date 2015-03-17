
Backbone   = require 'backbone'
$ = Backbone.$ = require 'jquery'
Router =  require './scripts/app/router'

MenuView = require './scripts/app/pages/view'
GlView =  require './scripts/app/gl/view'

Demos = require './scripts/shared/appDemos'

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
      console.log 'glDEMOTEST '
      console.log 'glDEMO', demoClass
      View = new GlView(el: 'body', demo:new demoClass({debug:@demos.get('isDebugging')}))

  __facitatePushState: ->
    if @demos.get('isPushState')
      $(document).on 'click', 'a:not([data-bypass])', (evt) =>
        href = $(evt.currentTarget)[0].href
        host = $(evt.currentTarget)[0].host
        split = href.split(host)
        newPage = split[1]
        @router.navigate newPage, {trigger: true}
        evt.preventDefault()

app = new App()
