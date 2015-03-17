var Backbone;

Backbone = require('backbone');

module.exports = Backbone.Model.extend({
  defaults: {
    isDebugging: true,
    isPushState: true,
    data: [
      {
        'url': 'basic',
        'name': 'basic',
        'demoClass': './scrips/app/gl/demos/basicdemo'
      }, {
        'url': 'shader',
        'name': 'shader',
        'demoClass': './scrips/app/gl/demos/shaderdemo'
      }, {
        'url': 'physics',
        'name': 'physics',
        'demoClass': './scrips/app/gl/demos/physidemo'
      }, {
        'url': 'goblin',
        'name': 'goblin',
        'demoClass': './scrips/app/gl/demos/goblindemo'
      }
    ]
  }
});
