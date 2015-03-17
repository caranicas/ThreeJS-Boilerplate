var $, AppRouter, Backbone,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

Backbone = require('backbone');

$ = require('jquery');

AppRouter = (function(superClass) {
  extend(AppRouter, superClass);

  function AppRouter(options) {
    AppRouter.__super__.constructor.apply(this, arguments);
    this.model = options.model;
    this.__createRoutes();
    this;
  }

  AppRouter.prototype.__createRoutes = function() {
    var bang, i, len, link, ref, results;
    this.route("", "index");
    bang = "";
    ref = this.model.get('data');
    results = [];
    for (i = 0, len = ref.length; i < len; i++) {
      link = ref[i];
      results.push(this.route(bang + link.url, link.name));
    }
    return results;
  };

  return AppRouter;

})(Backbone.Router);

module.exports = AppRouter;
