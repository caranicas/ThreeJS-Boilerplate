var $, App, Backbone, Demos, GlView, MenuView, Router, app,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Backbone = require('backbone');

$ = Backbone.$ = require('jquery');

Router = require('./scripts/app/router');

MenuView = require('./scripts/app/pages/view');

GlView = require('./scripts/app/gl/view');

Demos = require('./scripts/shared/appDemos');

App = (function() {
  App.prototype.isDebugging = true;

  function App() {
    this.__demoRouteFunction = bind(this.__demoRouteFunction, this);
    this.appIndex = bind(this.appIndex, this);
    this.demos = new Demos();
    this.router = new Router({
      model: this.demos
    });
    console.log('@router', this.router);
    this.__routeHandlers();
    this.__facitatePushState();
    Backbone.history.start({
      pushState: this.demos.get('isPushState')
    });
  }

  App.prototype.__routeHandlers = function() {
    var i, len, ref, results, route, routeName;
    this.router.on('route:index', this.appIndex);
    ref = this.demos.get('data');
    results = [];
    for (i = 0, len = ref.length; i < len; i++) {
      route = ref[i];
      routeName = 'route:' + route.name;
      results.push(this.router.on(routeName, this.__demoRouteFunction(route.demoClass)));
    }
    return results;
  };

  App.prototype.appIndex = function() {
    var IntroView;
    return IntroView = new MenuView({
      el: 'body',
      model: this.demos
    });
  };

  App.prototype.__demoRouteFunction = function(demoClass) {
    return (function(_this) {
      return function() {
        var View;
        return View = new GlView({
          el: 'body',
          demo: new demoClass({
            debug: _this.demos.get('isDebugging')
          })
        });
      };
    })(this);
  };

  App.prototype.__facitatePushState = function() {
    if (this.demos.get('isPushState')) {
      return $(document).on('click', 'a:not([data-bypass])', (function(_this) {
        return function(evt) {
          var host, href, newPage, split;
          href = $(evt.currentTarget)[0].href;
          host = $(evt.currentTarget)[0].host;
          split = href.split(host);
          newPage = split[1];
          _this.router.navigate(newPage, {
            trigger: true
          });
          return evt.preventDefault();
        };
      })(this));
    }
  };

  return App;

})();

app = new App();
