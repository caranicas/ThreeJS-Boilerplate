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
        'demoClass': require('./../app/gl/demos/basicdemo')
      }, {
        'url': 'shader',
        'name': 'shader',
        'demoClass': require('./../app/gl/demos/shaderdemo')
      }, {
        'url': 'physics',
        'name': 'physics',
        'demoClass': require('./../app/gl/demos/physidemo')
      }, {
        'url': 'goblin',
        'name': 'goblin',
        'demoClass': require('./../app/gl/demos/goblindemo')
      }
    ]
  }
});
