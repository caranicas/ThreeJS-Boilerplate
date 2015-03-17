var DemoInterface, Goblin, GoblinDemo, THREE, Utils,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

THREE = require('threejs');

Goblin = require('goblinphysics');

Utils = require('../../utils/goblinUtils');

DemoInterface = require('./DemoInterface');

GoblinDemo = (function(superClass) {
  extend(GoblinDemo, superClass);

  function GoblinDemo() {
    GoblinDemo.__super__.constructor.apply(this, arguments);
    this.objects = new Array();
  }

  GoblinDemo.prototype.threeInit = function() {
    return GoblinDemo.__super__.threeInit.apply(this, arguments);
  };

  GoblinDemo.prototype.__initScene = function() {
    GoblinDemo.__super__.__initScene.apply(this, arguments);
    this.__initGoblin();
    return console.log('world', this.world);
  };

  GoblinDemo.prototype.__initGoblin = function() {
    var BB, IS, NP;
    BB = new Goblin.BasicBroadphase();
    NP = new Goblin.NarrowPhase();
    IS = new Goblin.IterativeSolver();
    return this.world = new Goblin.World(BB, NP, IS);
  };

  GoblinDemo.prototype.__initGeometry = function() {
    GoblinDemo.__super__.__initGeometry.apply(this, arguments);
    this.__initBoxes();
    return this.__floorGeometry();
  };

  GoblinDemo.prototype.__initBoxes = function() {
    var metal_material, metalbox, wood_material, woodbox;
    wood_material = Utils.createMaterial('wood', 1, 1, this.renderer);
    metal_material = Utils.createMaterial('rusted_metal', 1, 1, this.renderer);
    woodbox = Utils.createBox(1, 1, 1, 100, wood_material, true);
    woodbox.goblin.position.y = 10;
    this.objects.push(woodbox);
    this.scene.add(woodbox);
    this.world.addRigidBody(woodbox.goblin);
    metalbox = Utils.createBox(1, 1, 1, 100, metal_material, true);
    metalbox.goblin.position.y = 14;
    metalbox.goblin.position.x = 1;
    this.objects.push(metalbox);
    this.scene.add(metalbox);
    return this.world.addRigidBody(metalbox.goblin);
  };

  GoblinDemo.prototype.__floorGeometry = function() {
    var material;
    material = Utils.createMaterial('pebbles', 5, 5, this.renderer);
    this.ground = Utils.createPlane(1, 20, 20, 0, material, true);
    this.ground.goblin.position.y = 0;
    this.ground.goblin.position.x = 0;
    this.objects.push(this.ground);
    this.scene.add(this.ground);
    return this.world.addRigidBody(this.ground.goblin);
  };

  GoblinDemo.prototype.__initLights = function() {
    var ambient_light, directional_light;
    ambient_light = new THREE.AmbientLight(new THREE.Color(0x333333));
    this.scene.add(ambient_light);
    directional_light = new THREE.DirectionalLight(new THREE.Color(0xFFFFFF));
    directional_light.position.set(10, 30, 20);
    directional_light.shadowCameraLeft = directional_light.shadowCameraBottom = -50;
    directional_light.shadowCameraRight = directional_light.shadowCameraTop = 50;
    directional_light.castShadow = true;
    directional_light.shadowCameraNear = 1;
    directional_light.shadowCameraFar = 50;
    directional_light.shadowCameraFov = 50;
    directional_light.shadowDarkness = 0.5;
    return this.scene.add(directional_light);
  };

  GoblinDemo.prototype.__update = function() {
    var i, len, object, ref, results;
    this.world.step(1 / 60);
    ref = this.objects;
    results = [];
    for (i = 0, len = ref.length; i < len; i++) {
      object = ref[i];
      object.position.set(object.goblin.position.x, object.goblin.position.y, object.goblin.position.z);
      results.push(object.quaternion.set(object.goblin.rotation.x, object.goblin.rotation.y, object.goblin.rotation.z, object.goblin.rotation.w));
    }
    return results;
  };

  return GoblinDemo;

})(DemoInterface);

module.exports = GoblinDemo;
