###*
# The Main enterance Into my App
#
# @classView
# @constructor
#
###

Backbone   = require 'backbone'
Demos = require './../demos'

module.exports = Backbone.View.extend
  template: require './template'

  initialize:(options) ->
    @model = new Demos()
    @render()

  render: ->
    @$el.html @template @model.toJSON()
