###*
# The Main enterance Into my App
#
# @classView
# @constructor
#
###
Backbone   = require 'backbone'
Demo = require './shaderdemo.coffee'

module.exports = Backbone.View.extend
  template: require './template'

  initialize: ->
    @render()

  render: ->
    @$el.html @template
    Demo.threeInit()
    Demo.loop()
