var $, DemoInterface, Orbit, Stats, THREE;

window.THREE = THREE = require('threejs');

$ = require('jquery');

Orbit = require('orbitcontrols');

Stats = require('stats');

DemoInterface = (function() {
  DemoInterface.prototype.sceneObjs = [];

  DemoInterface.prototype.debugging = false;

  function DemoInterface() {
    this.debugging = arguments[0].debug;
  }

  DemoInterface.prototype.threeInit = function() {
    this.__initScene();
    this.__initRenderer();
    this.__initCamera();
    this.__initGeometry();
    this.__initLights();
    if (this.debugging) {
      this.__debugStats();
    }
    return this;
  };

  DemoInterface.prototype.__initScene = function() {
    return this.scene = new THREE.Scene();
  };

  DemoInterface.prototype.__initRenderer = function() {
    this.webcan = $('#webgl-canvas');
    this.renderer = new THREE.WebGLRenderer({
      canvas: this.webcan[0]
    });
    return this.renderer.setSize(window.innerWidth, window.innerHeight);
  };

  DemoInterface.prototype.__initCamera = function() {
    var controls;
    this.camera = new THREE.PerspectiveCamera(100, window.innerWidth / window.innerHeight, 1, 10000);
    this.camera.position.z = 20;
    this.camera.position.y = 10;
    controls = new Orbit(this.camera);
    return controls.addEventListener('change', this.render);
  };

  DemoInterface.prototype.__initGeometry = function() {
    if (this.debugging) {
      return this.__axis();
    }
  };

  DemoInterface.prototype.__axis = function() {
    var axes;
    axes = new THREE.AxisHelper(100);
    return this.scene.add(axes);
  };

  DemoInterface.prototype.__initLights = function() {
    var directionalLight;
    directionalLight = new THREE.DirectionalLight(0xffffff, 0.5);
    directionalLight.position.set(-20, -20, -20);
    this.scene.add(directionalLight);
    directionalLight = new THREE.DirectionalLight(0xffffff, 0.5);
    directionalLight.position.set(20, 20, 20);
    return this.scene.add(directionalLight);
  };

  DemoInterface.prototype.__debugStats = function() {
    this.stats = new Stats();
    this.stats.setMode(0);
    this.stats.domElement.style.position = 'absolute';
    this.stats.domElement.style.left = '0px';
    this.stats.domElement.style.top = '0px';
    return document.body.appendChild(this.stats.domElement);
  };

  DemoInterface.prototype.loop = function() {
    requestAnimationFrame((function(_this) {
      return function() {
        return _this.loop();
      };
    })(this));
    this.__update();
    return this.__render();
  };

  DemoInterface.prototype.__render = function() {
    this.stats.begin();
    this.renderer.render(this.scene, this.camera);
    return this.stats.end();
  };

  DemoInterface.prototype.__update = function() {};

  return DemoInterface;

})();

module.exports = DemoInterface;
