###*
# The Main enterance Into my App
#
# @classView
# @constructor
#
###
#_          = require 'underscore'
Backbone   = require 'backbone'
Backbone.$ = require 'jquery'
Demo = require './shaderdemo.coffee'


module.exports = Backbone.View.extend
  template: require './template'

  initialize: ->
    @render()

  render: ->
    @$el.html @template
    Demo.threeInit()
    Demo.loop()
