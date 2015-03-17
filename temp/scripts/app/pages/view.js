
/**
 * The Main enterance Into my App
#
 * @classView
 * @constructor
#
 */
var Backbone, Pageview,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

Backbone = require('backbone');

module.exports = Pageview = (function(superClass) {
  extend(Pageview, superClass);

  function Pageview(args) {
    console.log('APP CON', args);
    Pageview.__super__.constructor.apply(this, arguments);
    this.render();
  }

  Pageview.prototype.render = function() {
    return this.$el.html(this.template(this.model.toJSON()));
  };

  return Pageview;

})(Backbone.View);
