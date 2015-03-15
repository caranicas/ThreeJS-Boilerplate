
Backbone   = require 'backbone'

module.exports = Backbone.Model.extend

  defaults:
    isDebugging:true
    isPushState:false
    data:[
      {
        'url':'/basic'
        'name':'basic'
        'demoClass':require './gl/demos/basicdemo'
      },
      {
        'url':'/shader'
        'name':'shader'
        'demoClass':require  './gl/demos/shaderdemo'
      },
      {
        'url':'/physics'
        'name':'physics'
        'demoClass':require './gl/demos/physidemo'
      },
      {
        'url':'/goblin'
        'name':'goblin'
        'demoClass':require './gl/demos/goblindemo'
      }

    ]
