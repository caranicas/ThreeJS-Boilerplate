THREE = require 'threejs'

# obnoxious hack around
Physijs = require 'physijs'
Physijs = window.Physijs

DemoInterface = require './DemoInterface'

class PhysiDemo extends DemoInterface

  __initScene: ->
    @scene = new Physijs.Scene()
    @scene.setGravity(new THREE.Vector3( 0, -30, 0 ))

  __initGeometry: ->
    @__initBoxes()
    @__floorGeometry()
    super

  __initBoxes: ->
    cubeGeo = new THREE.CubeGeometry( 5, 5, 5 )
    greyMat = new THREE.MeshLambertMaterial({ color: 0x888888 })
    pinkMat =new THREE.MeshLambertMaterial({ color: 0xff88ff })
    box = new Physijs.BoxMesh(cubeGeo ,greyMat)
    box.position.y = 30
    @scene.add( box )

    box_material = Physijs.createMaterial(pinkMat,.8,.4)
    boxtwo = new Physijs.BoxMesh(cubeGeo,pinkMat)

    boxtwo.position.y = 10
    boxtwo.position.x = 3

    @scene.add( boxtwo )


  __floorGeometry: ->
    textMat = new THREE.MeshLambertMaterial({ map: THREE.ImageUtils.loadTexture( 'textures/checkerboard.jpg' ) })
    ground_material = Physijs.createMaterial(textMat,.8,.4)
    ground_material.map.wrapS = ground_material.map.wrapT = THREE.RepeatWrapping
    ground_material.map.repeat.set( 3, 3 )
    ground = new Physijs.BoxMesh(new THREE.CubeGeometry(100, 1, 100),ground_material,0)
    ground.receiveShadow = true
    @scene.add(ground)

  __initLights: ->
    directionalLight = new THREE.DirectionalLight( 0x0000ff, 1 )
    directionalLight.position.set( -20, -20, -20)
    @scene.add( directionalLight )
    directionalLight = new THREE.DirectionalLight( 0xffffff, 1 )
    directionalLight.position.set(20,20,20)
    @scene.add( directionalLight )


  __update: ->
    @scene.simulate()

module.exports = PhysiDemo
