###*
# The Main enterance Into my App
#
# @classView
# @constructor
#
###
Backbone   = require 'backbone'

module.exports = Backbone.View.extend
  template: require './template'

  initialize:(options) ->
    @demo  = options.demo
    @render()

  render: ->
    @$el.html @template
    @demo.threeInit()
    @demo.loop()
