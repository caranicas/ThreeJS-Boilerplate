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
  demo:Demo

  initialize:(options) ->
    @demo  = options.demo
    @render()

  render: ->
    @$el.html @template
    @demo.threeInit()
    @demo.loop()
