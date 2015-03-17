var Backbone, GLView,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

Backbone = require('backbone');

GLView = (function(superClass) {
  extend(GLView, superClass);

  function GLView() {
    return GLView.__super__.constructor.apply(this, arguments);
  }

  GLView.prototype.template = require('./template.hbs');

  GLView.prototype.initialize = function(options) {
    this.demo = options.demo;
    return this.render();
  };

  GLView.prototype.render = function() {
    this.$el.html(this.template);
    this.demo.threeInit();
    return this.demo.loop();
  };

  return GLView;

})(Backbone.View);

module.exports = GLView;
