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
Demo = require './demo.coffee'

module.exports = Backbone.View.extend
  template: require './template'

  initialize: ->
    @render()
    console.log('init template', @template)

  render: ->
    @$el.html @template
    Demo.threeInit()
    Demo.loop()
