var Entity, THREE, Util;

THREE = require('THREE');

Util = require('../behaviors/behaviorUtil.coffee');

Entity = (function() {
  Entity.prototype.behavior = null;

  Entity.prototype.mesh = null;

  Entity.prototype.boundingSize = 100;

  Entity.prototype.acceleration = new THREE.Vector3(0, 0, 0);

  Entity.prototype.velocity = new THREE.Vector3(0, 0, 0);

  Entity.prototype.maxSpeed = 2;

  Entity.prototype.minSpeed = 0.3;

  Entity.prototype.maxForce = 0.05;

  function Entity() {
    this;
  }

  Entity.prototype.init = function(defaults) {
    this.behavior = defaults.behavior;
    this.mesh = defaults.mesh;
    this.boundingSize = defaults.bounding;
    this.velocity = defaults.velocity != null ? defaults.velocity : new THREE.Vector3(0.01, 0, 0);
    return this.acceleration = new THREE.Vector3(0.0, 0, 0);
  };

  Entity.prototype.update = function(objs) {
    this.behavior.update(objs);
    this.__updateVelocity();
    this.__updatePosition();
    this.__updateFacing();
    this.__loopPosition();
    return this.__clearAccel();
  };

  Entity.prototype.__updateVelocity = function() {
    this.velocity.add(this.acceleration);
    return this.__capVelocity();
  };

  Entity.prototype.__capVelocity = function() {
    return this.velocity = Util.limit(this.velocity, this.maxSpeed);
  };

  Entity.prototype.__clearAccel = function() {
    return this.acceleration = new THREE.Vector3(0, 0, 0);
  };

  Entity.prototype.__updatePosition = function() {
    this.mesh.position.x += this.velocity.x;
    this.mesh.position.y += this.velocity.y;
    return this.mesh.position.z += this.velocity.z;
  };

  Entity.prototype.__updateFacing = function() {
    var norm;
    norm = this.velocity.clone();
    norm.normalize();
    this.mesh.rotation.x = norm.z;
    this.mesh.rotation.y = norm.z;
    return this.mesh.rotation.z = norm.z;
  };

  Entity.prototype.__loopPosition = function() {
    var edges;
    edges = this.boundingSize / 2;
    if (this.mesh.position.x > edges) {
      this.mesh.position.x = -edges;
    } else if (this.mesh.position.x < -edges) {
      this.mesh.position.x = edges;
    }
    if (this.mesh.position.y > edges) {
      this.mesh.position.y = -edges;
    } else if (this.mesh.position.y < -edges) {
      this.mesh.position.y = edges;
    }
    if (this.mesh.position.z > edges) {
      return this.mesh.position.z = -edges;
    } else if (this.mesh.position.z < -edges) {
      return this.mesh.position.z = edges;
    }
  };

  Entity.prototype.debugRender = function() {};

  Entity.prototype.getPosition = function() {
    return this.mesh.position;
  };

  Entity.prototype.getVelocity = function() {
    return this.velocity;
  };

  Entity.prototype.getAcceleration = function() {
    return this.acceleration;
  };

  return Entity;

})();

module.exports = Entity;
