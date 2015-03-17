var BasicDemo, DemoInterface, THREE,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

THREE = require('threejs');

DemoInterface = require('./DemoInterface');

BasicDemo = (function(superClass) {
  extend(BasicDemo, superClass);

  function BasicDemo() {
    return BasicDemo.__super__.constructor.apply(this, arguments);
  }

  BasicDemo.prototype.__initGeometry = function() {
    this.__initBoxes();
    this.__floorGeometry();
    return BasicDemo.__super__.__initGeometry.apply(this, arguments);
  };

  BasicDemo.prototype.__initBoxes = function() {
    this.geometry = new THREE.BoxGeometry(5, 5, 5);
    this.material = new THREE.MeshLambertMaterial({
      color: 0xff00ff,
      wireframe: false
    });
    this.mesh = new THREE.Mesh(this.geometry, this.material);
    this.mesh.position.y = 10;
    this.mesh.position.x = 5;
    this.scene.add(this.mesh);
    this.sceneObjs.push(this.mesh);
    this.geometry = new THREE.BoxGeometry(5, 5, 5);
    this.material = new THREE.MeshLambertMaterial({
      color: 0xffff00,
      wireframe: false
    });
    this.mesh = new THREE.Mesh(this.geometry, this.material);
    this.mesh.position.y = 10;
    this.mesh.position.x = -5;
    this.scene.add(this.mesh);
    return this.sceneObjs.push(this.mesh);
  };

  BasicDemo.prototype.__floorGeometry = function() {
    var floor, floorGeometry, floorMaterial;
    this.floorTexture = new THREE.ImageUtils.loadTexture('textures/checkerboard.jpg');
    this.floorTexture.wrapT = THREE.RepeatWrapping;
    this.floorTexture.wrapS = this.floorTexture.wrapT;
    this.floorTexture.repeat.set(10, 10);
    floorMaterial = new THREE.MeshBasicMaterial({
      map: this.floorTexture,
      side: THREE.DoubleSide
    });
    floorGeometry = new THREE.PlaneGeometry(100, 100, 10, 10);
    floor = new THREE.Mesh(floorGeometry, floorMaterial);
    floor.position.y = -0.5;
    floor.rotation.x = Math.PI / 2;
    return this.scene.add(floor);
  };

  BasicDemo.prototype.__initLights = function() {
    var directionalLight;
    directionalLight = new THREE.DirectionalLight(0xffffff, 0.5);
    directionalLight.position.set(-20, -20, -20);
    this.scene.add(directionalLight);
    directionalLight = new THREE.DirectionalLight(0xffffff, 0.5);
    directionalLight.position.set(20, 20, 20);
    return this.scene.add(directionalLight);
  };

  BasicDemo.prototype.__update = function() {
    var i, len, mesh, ref, results;
    ref = this.sceneObjs;
    results = [];
    for (i = 0, len = ref.length; i < len; i++) {
      mesh = ref[i];
      mesh.rotation.x += 0.01;
      results.push(mesh.rotation.y += 0.02);
    }
    return results;
  };

  return BasicDemo;

})(DemoInterface);

module.exports = BasicDemo;
