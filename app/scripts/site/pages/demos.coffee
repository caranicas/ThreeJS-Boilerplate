
Backbone   = require 'backbone'

module.exports = Backbone.Model.extend

  defaults:
    links:[
      {
        'url':'/basic'
        'name':'basic'
      },
      {
        'url':'/shader'
        'name':'shader'
      },
      {
        'url':'/physics'
        'name':'physics'
      },
      {
        'url':'/goblin'
        'name':'goblin'
      }

    ]
