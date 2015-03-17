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
  #template: require './template'

  constructor:(args) ->
    console.log 'APP CON', args
    #@model = options.data
    super
    @render()

  render: ->
    @$el.html @template @model.toJSON()
