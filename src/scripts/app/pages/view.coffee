###*
# The Main enterance Into my App
#
# @classView
# @constructor
#
###

Backbone   = require 'backbone'
#Demos = require './../demos'
module.exports = class Pageview extends Backbone.View
  template: require './template.hbs'

  constructor:(args) ->
    console.log 'ARGS', args
    @model = args.model
    super
    @render()

  render: ->
    console.log 'template',@template
    @$el.html @template @model.toJSON()
