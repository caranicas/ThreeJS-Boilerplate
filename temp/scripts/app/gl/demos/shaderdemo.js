var DemoInterface, DotScreenShader, EffectComposer, RGBShiftShader, ShaderDemo, THREE,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

THREE = require('threejs');

EffectComposer = require('effectcomposer');

DotScreenShader = require('dotscreenshader');

RGBShiftShader = require('rgbshiftshader');

DemoInterface = require('./DemoInterface');

ShaderDemo = (function(superClass) {
  extend(ShaderDemo, superClass);

  function ShaderDemo() {
    return ShaderDemo.__super__.constructor.apply(this, arguments);
  }

  ShaderDemo.prototype.threeInit = function() {
    ShaderDemo.__super__.threeInit.apply(this, arguments);
    this.__initShader();
    return this.__createShaderEffects();
  };

  ShaderDemo.prototype.__initShader = function() {
    console.log('composer', EffectComposer);
    this.composer = new EffectComposer(this.renderer);
    return this.composer.addPass(new EffectComposer.prototype.RenderPass(this.scene, this.camera));
  };

  ShaderDemo.prototype.__createShaderEffects = function() {
    var effect;
    effect = new EffectComposer.prototype.ShaderPass(new DotScreenShader());
    effect.uniforms['scale'].value = 4;
    this.composer.addPass(effect);
    effect = new EffectComposer.prototype.ShaderPass(new RGBShiftShader());
    effect.uniforms['amount'].value = 0.0015;
    effect.renderToScreen = true;
    return this.composer.addPass(effect);
  };

  ShaderDemo.prototype.__initGeometry = function() {
    ShaderDemo.__super__.__initGeometry.apply(this, arguments);
    return this.__initBoxes();
  };

  ShaderDemo.prototype.__initBoxes = function() {
    this.geometry = new THREE.BoxGeometry(5, 5, 5);
    this.material = new THREE.ShaderMaterial({
      color: 0xff00ff,
      shading: THREE.FlatShading
    });
    this.mesh = new THREE.Mesh(this.geometry, this.material);
    this.mesh.position.y = 10;
    this.mesh.position.x = 5;
    this.scene.add(this.mesh);
    return this.sceneObjs.push(this.mesh);
  };

  ShaderDemo.prototype.__initLights = function() {
    var directionalLight;
    directionalLight = new THREE.DirectionalLight(0xffffff, 0.5);
    directionalLight.position.set(-20, -20, -20);
    this.scene.add(directionalLight);
    directionalLight = new THREE.DirectionalLight(0xffffff, 0.5);
    directionalLight.position.set(20, 20, 20);
    return this.scene.add(directionalLight);
  };

  ShaderDemo.prototype.__floorGeometry = function() {
    var floor, floorGeometry, floorMaterial;
    this.floorTexture = new THREE.ImageUtils.loadTexture('textures/checkerboard.jpg');
    this.floorTexture.wrapT = THREE.RepeatWrapping;
    this.floorTexture.wrapS = this.floorTexture.wrapT;
    this.floorTexture.repeat.set(10, 10);
    floorMaterial = new THREE.MeshPhongMaterial({
      map: this.floorTexture,
      side: THREE.DoubleSide,
      shading: THREE.FlatShading
    });
    floorGeometry = new THREE.PlaneGeometry(100, 100, 10, 10);
    floor = new THREE.Mesh(floorGeometry, floorMaterial);
    floor.position.y = -0.5;
    floor.rotation.x = Math.PI / 2;
    return this.scene.add(floor);
  };

  ShaderDemo.prototype.loop = function() {
    requestAnimationFrame((function(_this) {
      return function() {
        return _this.loop();
      };
    })(this));
    this.update();
    return this.render();
  };

  ShaderDemo.prototype.render = function() {
    this.stats.begin();
    this.composer.render();
    return this.stats.end();
  };

  ShaderDemo.prototype.update = function() {
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

  return ShaderDemo;

})(DemoInterface);

module.exports = ShaderDemo;
