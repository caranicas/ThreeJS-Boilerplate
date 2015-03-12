THREE = require 'threejs'
Goblin = require 'goblinphysics'
Utils = require '../utils/goblinUtils'

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

    BB = new Goblin.BasicBroadphase()
    NP = new Goblin.NarrowPhase()
    IS = new Goblin.IterativeSolver()
    @world = new Goblin.World(BB, NP, IS)
    console.log 'world', @world

  __initGeometry: ->
    super
    @__initBoxes()
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
    material = Utils.createMaterial('pebbles', 5, 5,@renderer)
    @ground = Utils.createPlane( 1, 20, 20, 0,material, true)
    @ground.position.y = -0.5
    @ground.position.x = -0.5
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

module.exports = GoblinDemo
