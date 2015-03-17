
class GoblinUtils

  materials:
    wood:
      diffuse: 'textures/228_diffuse.png'
      normal: 'textures/228_normal.png'
      normal_scale: 7
    pebbles:
      diffuse: 'textures/254_diffuse.png'
      normal: 'textures/254_normal.png'
      normal_scale: 4
    rusted_metal:
      diffuse: 'textures/210_diffuse.png'
      normal: 'textures/210_normal.png'
      specular: 'textures/210_specular.png'
      shininess: 200
      normal_scale: 4
      metal: true

    scratched_metal:
      diffuse: 'textures/213_diffuse.png'
      normal: 'textures/213_normal.png'
      specular: 'textures/213_specular.png'
      shininess: 300
      normal_scale: 3
      metal: true

    cement:
      diffuse: '173_diffuse.png'
      normal: '173_normal.png'
      specular: '173_specular.png'
      shininess: 30
      normal_scale: 2


  createPlane:( orientation, half_width, half_length, mass, material, hasShadow ) ->
    width = if orientation is 1 or orientation is 2 then half_width * 2 else 0.01
    height = if orientation is 0 then half_width * 2 else if orientation is 2 then half_length * 2 else 0.01
    depth = if orientation is 0 or orientation is 1 then half_length * 2 else 0.01

    plane = new THREE.Mesh(new THREE.BoxGeometry(width, height, depth),material)
    plane.castShadow = hasShadow
    plane.receiveShadow = hasShadow
    #new Goblin.PlaneShape( orientation, half_width, half_length ),
    plane.goblin = new Goblin.RigidBody(new Goblin.BoxShape(width, height, depth),mass)

    plane

  createBox:( half_width, half_height, half_length, mass, material,hasShadow ) ->
    box = new THREE.Mesh(new THREE.BoxGeometry( half_width * 2, half_height * 2, half_length * 2 ),material)
    box.castShadow = hasShadow
    box.receiveShadow = hasShadow
    box.goblin = new Goblin.RigidBody(new Goblin.BoxShape( half_width, half_height, half_length ),mass)

    box

  createMaterial:( name, repeat_x, repeat_y,renderer) ->
    def = @materials[name]
    map = THREE.ImageUtils.loadTexture(def.diffuse )
    material_def =
      shininess: 0
      wireframe: false

    console.log 'material_def', material_def
    map.repeat.x = repeat_x
    map.repeat.y = repeat_y
    map.wrapS = map.wrapT = THREE.RepeatWrapping
    map.anisotropy = renderer.getMaxAnisotropy()
    material_def.map = map

    if def.normal?
      normalMap = THREE.ImageUtils.loadTexture(def.normal, THREE.RepeatWrapping )
      normalMap.repeat.x = repeat_x
      normalMap.repeat.y = repeat_y
      normalMap.wrapS = normalMap.wrapT = THREE.RepeatWrapping
      normalMap.anisotropy = renderer.getMaxAnisotropy()
      material_def.normalMap = normalMap

    if def.specular?
      specularMap = THREE.ImageUtils.loadTexture(def.specular, THREE.RepeatWrapping )
      specularMap.repeat.x = repeat_x
      specularMap.repeat.y = repeat_y
      specularMap.wrapS = specularMap.wrapT = THREE.RepeatWrapping
      specularMap.anisotropy = renderer.getMaxAnisotropy()
      material_def.specularMap = specularMap
      material_def.shininess = def.shininess

    console.log 'material_def', material_def
    material = new THREE.MeshPhongMaterial( material_def )

    if def.normal_scale?
      material.normalScale.set( def.normal_scale, def.normal_scale )

    if def.metal is true
      material.metal = true

    material


module.exports = new GoblinUtils
