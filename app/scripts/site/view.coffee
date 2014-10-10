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
  template: require './template.hbs'

  initialize: ->
    @render()

  render: ->
    Demo.threeInit()
    Demo.loop()