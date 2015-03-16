Backbone   = require 'backbone'

class GLView extends Backbone.View
  template: require './template'

  initialize:(options) ->
    @demo  = options.demo
    @render()

  render: ->
    @$el.html @template
    @demo.threeInit()
    @demo.loop()


module.exports = GLView
