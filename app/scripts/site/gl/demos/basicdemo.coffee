THREE = require 'threejs'
DemoInterface = require './DemoInterface'

class BasicDemo extends DemoInterface

  LightObj:
    lightOneColor:0x00ff00
    lightTwoColor:0xffffff

  __initGeometry: ->
    @__initBoxes()
    @__floorGeometry()
    super

  __initBoxes: ->
    @geometry = new THREE.BoxGeometry( 5, 5, 5 )
    @material = new THREE.MeshLambertMaterial( { color: 0xffffff, wireframe: false} )
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
    @floorTexture = new THREE.ImageUtils.loadTexture( 'textures/checkerboard.jpg' )
    @floorTexture.wrapT = THREE.RepeatWrapping
    @floorTexture.wrapS = @floorTexture.wrapT
    @floorTexture.repeat.set( 10, 10 )
    floorMaterial = new THREE.MeshBasicMaterial( { map: @floorTexture, side: THREE.DoubleSide } )
    floorGeometry = new THREE.PlaneGeometry(100, 100, 10, 10)
    floor = new THREE.Mesh(floorGeometry, floorMaterial)
    floor.position.y = -0.5
    floor.rotation.x = Math.PI / 2
    @scene.add(floor)

  __initDat:->
    super
    lightOneController = @dat.addColor(@LightObj, 'lightOneColor')
    lightTwoController = @dat.addColor(@LightObj, 'lightTwoColor')

    lightOneController.onChange( (value)=>
      @__updateLightOne(value)
    )

    lightTwoController.onChange( (value)=>
      @__updateLightTwo(value)
    )

  __updateLightOne:(value) ->
    @directionalLightOne.color.setHex(value)
    @

  __updateLightTwo:(value) ->
    @directionalLightTwo.color.setHex(value)
    @

  __initLights: ->
    @directionalLightOne = new THREE.DirectionalLight( @LightObj.lightOneColor, 0.5 )
    @directionalLightOne.position.set(-10, -10, -10)
    @scene.add( @directionalLightOne )

    @directionalLightTwo = new THREE.DirectionalLight( @LightObj.lightTwoColor, 0.5 )
    @directionalLightTwo.position.set(10,10,10)
    @scene.add( @directionalLightTwo )

  __update: ->
    for mesh in @sceneObjs
      mesh.rotation.x += 0.01
      mesh.rotation.y += 0.02

module.exports = BasicDemo
