
Backbone   = require 'backbone'


# basicDemo = require './gl/demos/basicdemo.coffee'
# physiDemo = require './gl/demos/physidemo.coffee'
# shaderDemo = require './gl/demos/shaderdemo.coffee'
# goblinDemo = require './gl/demos/goblindemo.coffee'


module.exports = Backbone.Model.extend

  defaults:
    data:[
      {
        'url':'/basic'
        'name':'basic'
        'demoClass':require './gl/demos/basicdemo.coffee'

      },
      {
        'url':'/shader'
        'name':'shader'
        'demoClass':require  './gl/demos/physidemo.coffee'
      },
      {
        'url':'/physics'
        'name':'physics'
        'demoClass':require './gl/demos/shaderdemo.coffee'
      },
      {
        'url':'/goblin'
        'name':'goblin'
        'demoClass':require './gl/demos/goblindemo.coffee'
      }

    ]
