THREE = require 'threejs'
Goblin = require 'goblinphysics'


DemoInterface = require './DemoInterface'

class GoblinDemo extends DemoInterface

  constructor: ->
    super
    @objects = new Array()

  threeInit: ->
    #@__initGoblin()
    super

  __initScene: ->
    super
    console.log 'goblin', Goblin

    # @webcan = $('#webgl-canvas')
    @renderer = new THREE.WebGLRenderer({canvas:@webcan[0]})
    @renderer.setSize( window.innerWidth, window.innerHeight )

    BB = new Goblin.BasicBroadphase()
    NP = new Goblin.NarrowPhase()
    IS = new Goblin.IterativeSolver()
    @world = new Goblin.World(BB, NP, IS)
    console.log 'world', @world

  __initGeometry: ->
    super
    #@__initBoxes()
    @__floorGeometry()

  __initBoxes:() ->
    material = new THREE.MeshLambertMaterial( { color: 0xffff00, wireframe: false} )
    box = new THREE.Mesh(new THREE.BoxGeometry(2,2,2),material)
    box.castShadow = true
    box.receiveShadow = true
    box.goblin = new Goblin.RigidBody(new Goblin.BoxShape(2,2,2),3)
    box.position.y = 10
    box.position.x = 3
    @objects.push(box)
    @scene.add(box)
    @world.addRigidBody(box.goblin)


    #1, 20, 20, 0, exampleUtils.createMaterial( 'pebbles', 5, 5 )
  __floorGeometry: ->
    @ground = @__createPlane( 1, 20, 20, 0, @__floorMaterial( 5, 5 ) )
    #material = @__floorMaterial()
    #plane = new THREE.Mesh(new THREE.BoxGeometry( 1, 1, 1),  material)
    #plane.castShadow = true
    #plane.receiveShadow = true
    #plane.goblin = new Goblin.RigidBody(
    # //new Goblin.PlaneShape( orientation, half_width, half_length ),
    #
    # new Goblin.BoxShape(
    # orientation === 1 || orientation === 2 ? half_width : 0.005,
    # orientation === 0 ? half_width : ( orientation === 2 ? half_length : 0.005 ),
    # orientation === 0 || orientation === 1 ? half_length : 0.005
    # ),
    # mass
    # )
    #
    @objects.push( @ground  )
    @exampleUtils.scene.add( @ground  )
    @world.addRigidBody( @ground.goblin )
    #
    # return plane

  __createPlane:( orientation, half_width, half_length, mass, material ) ->
    # plane = new THREE.Mesh(
    #   new THREE.BoxGeometry(
    #   orientation === 1 || orientation === 2 ? half_width * 2 : 0.01,
    #   orientation === 0 ? half_width * 2 : ( orientation === 2 ? half_length * 2 : 0.01 ),
    #   orientation === 0 || orientation === 1 ? half_length * 2 : 0.01
    #   ),
    #   material
    # )
    plane.castShadow = true
    plane.receiveShadow = true
    #new Goblin.PlaneShape( orientation, half_width, half_length ),
    plane.goblin = new Goblin.RigidBody(
    new Goblin.BoxShape(
      orientation === 1 || orientation === 2 ? half_width : 0.005,
      orientation === 0 ? half_width : ( orientation === 2 ? half_length : 0.005 ),
      orientation === 0 || orientation === 1 ? half_length : 0.005
      ),
      mass
    )

    #objects.push( plane )
    #exampleUtils.scene.add( plane )
    #world.addRigidBody( plane.goblin )

    return plane


  __floorMaterial:( repeat_x, repeat_y)->
    #var def = exampleUtils.materials[name],
    map = THREE.ImageUtils.loadTexture('images/checkerboard.jpg')
    #normalMap, specularMap,
    material_def = {
      shininess: 0
    }

    map.repeat.x = repeat_x
    map.repeat.y = repeat_y
    map.wrapS = map.wrapT = THREE.RepeatWrapping
    map.anisotropy = @renderer.getMaxAnisotropy()
    material_def.map = map

    # if ( def.normal ) {
    # normalMap = THREE.ImageUtils.loadTexture( 'textures/' + def.normal, THREE.RepeatWrapping );
    # normalMap.repeat.x = repeat_x;
    # normalMap.repeat.y = repeat_y;
    # normalMap.wrapS = normalMap.wrapT = THREE.RepeatWrapping;
    # normalMap.anisotropy = renderer.getMaxAnisotropy();
    # material_def.normalMap = normalMap;
    # }
    #
    # if ( def.specular ) {
    # specularMap = THREE.ImageUtils.loadTexture( 'textures/' + def.specular, THREE.RepeatWrapping );
    # specularMap.repeat.x = repeat_x;
    # specularMap.repeat.y = repeat_y;
    # specularMap.wrapS = specularMap.wrapT = THREE.RepeatWrapping;
    # specularMap.anisotropy = renderer.getMaxAnisotropy();
    # material_def.specularMap = specularMap;
    # material_def.shininess = def.shininess;
    # }

    material = new THREE.MeshPhongMaterial( material_def )

    #if ( def.normal_scale ) {
    #material.normalScale.set( def.normal_scale, def.normal_scale );
    #}

    #if ( def.metal ) {
    #material.metal = true;
    #}

    #return material


  __initLights: ->


  __update: ->
    @world.step( 1 / 60 )

module.exports = GoblinDemo
