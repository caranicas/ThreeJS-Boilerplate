var Boid, Entity,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Entity = require('./entity.coffee');

Boid = (function(_super) {
  __extends(Boid, _super);

  Boid.prototype.sepRad = 10;

  Boid.prototype.aligRad = 40;

  Boid.prototype.cohRad = 50;

  Boid.prototype.sepWeight = 3;

  Boid.prototype.cohWeight = 1.5;

  Boid.prototype.aligWeight = 2;

  Boid.prototype.maxAvoid = 3;

  Boid.prototype.maxSeeAhead = 100;

  Boid.prototype.debugAheadCatch = null;

  Boid.prototype.debugVel = null;

  Boid.prototype.debugLooK = null;

  function Boid() {
    Boid.__super__.constructor.apply(this, arguments);
    this;
  }

  Boid.prototype.init = function(defaults) {
    Boid.__super__.init.call(this, defaults);
    return this;
  };

  return Boid;

})(Entity);

module.exports = Boid;
