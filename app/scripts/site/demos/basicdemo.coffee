THREE = require 'threejs'
DemoInterface = require './DemoInterface'

class BasicDemo extends DemoInterface

  __initGeometry: ->
    @__initBoxes()
    @__floorGeometry()
    super

  __initBoxes: ->
    @geometry = new THREE.BoxGeometry( 5, 5, 5 )
    @material = new THREE.MeshLambertMaterial( { color: 0xff00ff, wireframe: false} )
    @mesh = new THREE.Mesh( @geometry, @material )
    @mesh.position.y = 10
    @mesh.position.x = 5
    @scene.add(@mesh)
    @sceneObjs.push(@mesh)

    @geometry = new THREE.BoxGeometry( 5, 5, 5 )
    @material = new THREE.MeshLambertMaterial( { color: 0xffff00, wireframe: false} )
    @mesh = new THREE.Mesh( @geometry, @material )
    @mesh.position.y = 10
    @mesh.position.x = -5
    @scene.add(@mesh)
    @sceneObjs.push(@mesh)

  __floorGeometry: ->
    @floorTexture = new THREE.ImageUtils.loadTexture( 'images/checkerboard.jpg' )
    @floorTexture.wrapT = THREE.RepeatWrapping
    @floorTexture.wrapS = @floorTexture.wrapT
    @floorTexture.repeat.set( 10, 10 )
    floorMaterial = new THREE.MeshBasicMaterial( { map: @floorTexture, side: THREE.DoubleSide } )
    floorGeometry = new THREE.PlaneGeometry(100, 100, 10, 10)
    floor = new THREE.Mesh(floorGeometry, floorMaterial)
    floor.position.y = -0.5
    floor.rotation.x = Math.PI / 2
    @scene.add(floor)

  __initLights: ->
    directionalLight = new THREE.DirectionalLight( 0xffffff, 0.5 )
    directionalLight.position.set( -20, -20, -20)
    @scene.add( directionalLight )

    directionalLight = new THREE.DirectionalLight( 0xffffff, 0.5 )
    directionalLight.position.set(20,20,20)
    @scene.add( directionalLight )

  __update: ->
    for mesh in @sceneObjs
      mesh.rotation.x += 0.01
      mesh.rotation.y += 0.02

module.exports = BasicDemo
