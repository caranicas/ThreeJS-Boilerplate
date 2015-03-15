###*
# The Main enterance Into my App
#
# @classView
# @constructor
#
###

Backbone   = require 'backbone'
Links = require './links'

module.exports = Backbone.View.extend
  template: require './template'

  initialize:(options) ->
    @model = new Links()
    console.log "LINKS", @model
    @render()

  render: ->
    @$el.html @template @model.toJSON()
