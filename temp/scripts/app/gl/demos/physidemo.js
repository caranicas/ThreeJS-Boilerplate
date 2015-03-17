var DemoInterface, PhysiDemo, Physijs, THREE,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

THREE = require('threejs');

Physijs = require('physijs');

Physijs = window.Physijs;

DemoInterface = require('./DemoInterface');

PhysiDemo = (function(superClass) {
  extend(PhysiDemo, superClass);

  function PhysiDemo() {
    return PhysiDemo.__super__.constructor.apply(this, arguments);
  }

  PhysiDemo.prototype.__initScene = function() {
    this.scene = new Physijs.Scene();
    return this.scene.setGravity(new THREE.Vector3(0, -30, 0));
  };

  PhysiDemo.prototype.__initGeometry = function() {
    this.__initBoxes();
    this.__floorGeometry();
    return PhysiDemo.__super__.__initGeometry.apply(this, arguments);
  };

  PhysiDemo.prototype.__initBoxes = function() {
    var box, box_material, boxtwo, cubeGeo, greyMat, pinkMat;
    cubeGeo = new THREE.CubeGeometry(5, 5, 5);
    greyMat = new THREE.MeshLambertMaterial({
      color: 0x888888
    });
    pinkMat = new THREE.MeshLambertMaterial({
      color: 0xff88ff
    });
    box = new Physijs.BoxMesh(cubeGeo, greyMat);
    box.position.y = 30;
    this.scene.add(box);
    box_material = Physijs.createMaterial(pinkMat, .8, .4);
    boxtwo = new Physijs.BoxMesh(cubeGeo, pinkMat);
    boxtwo.position.y = 10;
    boxtwo.position.x = 3;
    return this.scene.add(boxtwo);
  };

  PhysiDemo.prototype.__floorGeometry = function() {
    var ground, ground_material, textMat;
    textMat = new THREE.MeshLambertMaterial({
      map: THREE.ImageUtils.loadTexture('textures/checkerboard.jpg')
    });
    ground_material = Physijs.createMaterial(textMat, .8, .4);
    ground_material.map.wrapS = ground_material.map.wrapT = THREE.RepeatWrapping;
    ground_material.map.repeat.set(3, 3);
    ground = new Physijs.BoxMesh(new THREE.CubeGeometry(100, 1, 100), ground_material, 0);
    ground.receiveShadow = true;
    return this.scene.add(ground);
  };

  PhysiDemo.prototype.__initLights = function() {
    var directionalLight;
    directionalLight = new THREE.DirectionalLight(0x0000ff, 1);
    directionalLight.position.set(-20, -20, -20);
    this.scene.add(directionalLight);
    directionalLight = new THREE.DirectionalLight(0xffffff, 1);
    directionalLight.position.set(20, 20, 20);
    return this.scene.add(directionalLight);
  };

  PhysiDemo.prototype.__update = function() {
    return this.scene.simulate();
  };

  return PhysiDemo;

})(DemoInterface);

module.exports = PhysiDemo;
