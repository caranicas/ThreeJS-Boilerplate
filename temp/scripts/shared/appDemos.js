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
        'demoClass': './scripts/app/gl/demos/basicdemo'
      }, {
        'url': 'shader',
        'name': 'shader',
        'demoClass': './scripts/app/gl/demos/shaderdemo'
      }, {
        'url': 'physics',
        'name': 'physics',
        'demoClass': './scripts/app/gl/demos/physidemo'
      }, {
        'url': 'goblin',
        'name': 'goblin',
        'demoClass': './scripts/app/gl/demos/goblindemo'
      }
    ]
  }
});
