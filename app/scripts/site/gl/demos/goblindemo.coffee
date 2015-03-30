THREE = require 'threejs'
Goblin = require 'goblinphysics'
Utils = require '../../utils/goblinUtils'

DemoInterface = require './DemoInterface'

class GoblinDemo extends DemoInterface

  constructor: ->
    super
    @objects = new Array()

  threeInit: ->
    #
    super

  __initScene: ->
    super
    @__initGoblin()
    console.log 'world', @world

  __initGoblin: ->
    BB = new Goblin.BasicBroadphase()
    NP = new Goblin.NarrowPhase()
    IS = new Goblin.IterativeSolver()
    @world = new Goblin.World(BB, NP, IS)

  __initGeometry: ->
    super
    @__initBoxes()
    @__floorGeometry()

  __initBoxes:() ->
    wood_material = Utils.createMaterial( 'wood', 1, 1,@renderer)
    metal_material = Utils.createMaterial( 'rusted_metal', 1, 1,@renderer)
    woodbox = Utils.createBox( 1, 1, 1, 100, wood_material, true )
    woodbox.goblin.position.y = 10
    woodbox.goblin.linear_velocity.y = 20
    @objects.push(woodbox)
    @scene.add(woodbox)
    @world.addRigidBody(woodbox.goblin)


    metalbox = Utils.createBox( 1, 1, 1, 100, metal_material, true )
    metalbox.goblin.position.y = 14
    metalbox.goblin.position.x = 1
    metalbox.goblin.linear_velocity.y = 10
    console.log 'Goblin', metalbox.goblin
    @objects.push(metalbox)
    @scene.add(metalbox)
    @world.addRigidBody(metalbox.goblin)


    #1, 20, 20, 0, exampleUtils.createMaterial( 'pebbles', 5, 5 )
  __floorGeometry: ->
    material = Utils.createMaterial('pebbles', 5, 5,@renderer)
    @ground = Utils.createPlane( 1, 20, 20, 0,material, true)
    @ground.goblin.position.y = 0
    @ground.goblin.position.x = 0
    @objects.push( @ground  )
    @scene.add( @ground  )
    @world.addRigidBody( @ground.goblin )

  __initLights: ->
    ambient_light = new THREE.AmbientLight( new THREE.Color( 0x333333 ) )
    @scene.add( ambient_light )
    directional_light = new THREE.DirectionalLight( new THREE.Color( 0xFFFFFF ) )
    directional_light.position.set( 10, 30, 20 )
    directional_light.shadowCameraLeft = directional_light.shadowCameraBottom = -50
    directional_light.shadowCameraRight = directional_light.shadowCameraTop = 50
    directional_light.castShadow = true
    directional_light.shadowCameraNear = 1
    directional_light.shadowCameraFar = 50
    directional_light.shadowCameraFov = 50
    directional_light.shadowDarkness = 0.5
    @scene.add( directional_light )

  __update: ->
    @world.step( 1 / 60 )
    for object in @objects
      object.position.set(object.goblin.position.x,object.goblin.position.y,object.goblin.position.z)
      object.quaternion.set(object.goblin.rotation.x,object.goblin.rotation.y,object.goblin.rotation.z,object.goblin.rotation.w)


module.exports = GoblinDemo
