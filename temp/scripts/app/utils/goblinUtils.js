var GoblinUtils;

GoblinUtils = (function() {
  function GoblinUtils() {}

  GoblinUtils.prototype.materials = {
    wood: {
      diffuse: 'textures/228_diffuse.png',
      normal: 'textures/228_normal.png',
      normal_scale: 7
    },
    pebbles: {
      diffuse: 'textures/254_diffuse.png',
      normal: 'textures/254_normal.png',
      normal_scale: 4
    },
    rusted_metal: {
      diffuse: 'textures/210_diffuse.png',
      normal: 'textures/210_normal.png',
      specular: 'textures/210_specular.png',
      shininess: 200,
      normal_scale: 4,
      metal: true
    },
    scratched_metal: {
      diffuse: 'textures/213_diffuse.png',
      normal: 'textures/213_normal.png',
      specular: 'textures/213_specular.png',
      shininess: 300,
      normal_scale: 3,
      metal: true
    },
    cement: {
      diffuse: '173_diffuse.png',
      normal: '173_normal.png',
      specular: '173_specular.png',
      shininess: 30,
      normal_scale: 2
    }
  };

  GoblinUtils.prototype.createPlane = function(orientation, half_width, half_length, mass, material, hasShadow) {
    var depth, height, plane, width;
    width = orientation === 1 || orientation === 2 ? half_width * 2 : 0.01;
    height = orientation === 0 ? half_width * 2 : orientation === 2 ? half_length * 2 : 0.01;
    depth = orientation === 0 || orientation === 1 ? half_length * 2 : 0.01;
    plane = new THREE.Mesh(new THREE.BoxGeometry(width, height, depth), material);
    plane.castShadow = hasShadow;
    plane.receiveShadow = hasShadow;
    plane.goblin = new Goblin.RigidBody(new Goblin.BoxShape(width, height, depth), mass);
    return plane;
  };

  GoblinUtils.prototype.createBox = function(half_width, half_height, half_length, mass, material, hasShadow) {
    var box;
    box = new THREE.Mesh(new THREE.BoxGeometry(half_width * 2, half_height * 2, half_length * 2), material);
    box.castShadow = hasShadow;
    box.receiveShadow = hasShadow;
    box.goblin = new Goblin.RigidBody(new Goblin.BoxShape(half_width, half_height, half_length), mass);
    return box;
  };

  GoblinUtils.prototype.createMaterial = function(name, repeat_x, repeat_y, renderer) {
    var def, map, material, material_def, normalMap, specularMap;
    def = this.materials[name];
    map = THREE.ImageUtils.loadTexture(def.diffuse);
    material_def = {
      shininess: 0,
      wireframe: false
    };
    console.log('material_def', material_def);
    map.repeat.x = repeat_x;
    map.repeat.y = repeat_y;
    map.wrapS = map.wrapT = THREE.RepeatWrapping;
    map.anisotropy = renderer.getMaxAnisotropy();
    material_def.map = map;
    if (def.normal != null) {
      normalMap = THREE.ImageUtils.loadTexture(def.normal, THREE.RepeatWrapping);
      normalMap.repeat.x = repeat_x;
      normalMap.repeat.y = repeat_y;
      normalMap.wrapS = normalMap.wrapT = THREE.RepeatWrapping;
      normalMap.anisotropy = renderer.getMaxAnisotropy();
      material_def.normalMap = normalMap;
    }
    if (def.specular != null) {
      specularMap = THREE.ImageUtils.loadTexture(def.specular, THREE.RepeatWrapping);
      specularMap.repeat.x = repeat_x;
      specularMap.repeat.y = repeat_y;
      specularMap.wrapS = specularMap.wrapT = THREE.RepeatWrapping;
      specularMap.anisotropy = renderer.getMaxAnisotropy();
      material_def.specularMap = specularMap;
      material_def.shininess = def.shininess;
    }
    console.log('material_def', material_def);
    material = new THREE.MeshPhongMaterial(material_def);
    if (def.normal_scale != null) {
      material.normalScale.set(def.normal_scale, def.normal_scale);
    }
    if (def.metal === true) {
      material.metal = true;
    }
    return material;
  };

  return GoblinUtils;

})();

module.exports = new GoblinUtils;
