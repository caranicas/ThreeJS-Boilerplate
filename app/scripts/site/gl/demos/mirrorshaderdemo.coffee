THREE = require 'threejs'

EffectComposer = require 'effectcomposer'
MirrorShader = require 'mirrorshader'

DemoInterface = require './DemoInterface'


class MirrorShaderDemo extends DemoInterface


  threeInit: ->
    super
    @__initShader()
    @__createShaderEffects()

  __initShader: ->
    console.log('composer', EffectComposer)
    @composer = new EffectComposer( @renderer )
    @composer.addPass( new EffectComposer.prototype.RenderPass( @scene, @camera ) )

  __createShaderEffects: ->
    mirShade  = new MirrorShader()
    console.log 'mirShade', mirShade
    mirrorPass = new EffectComposer.prototype.ShaderPass(mirShade)
    mirrorPass.renderToScreen = true;
    mirrorPass.uniforms[ "side" ].value = 1
    console.log 'mirrorPass', mirrorPass.uniforms
    #mirrorPass.uniforms[ "side" ].value = 1
    @composer.addPass(mirrorPass)

  __initGeometry: ->
    super
    @__initBoxes()

  __initBoxes: ->
    @geometry = new THREE.BoxGeometry( 5, 5, 5 )
    @material = new THREE.ShaderMaterial( { color: 0xff00ff, shading: THREE.FlatShading } )
    @mesh = new THREE.Mesh( @geometry, @material )
    @mesh.position.y = 10
    @mesh.position.x = 5
    @scene.add(@mesh)
    @sceneObjs.push(@mesh)

  __initLights: ->
    directionalLight = new THREE.DirectionalLight( 0xffffff, 0.5 )
    directionalLight.position.set( -20, -20, -20)
    @scene.add( directionalLight )

    directionalLight = new THREE.DirectionalLight( 0xffffff, 0.5 )
    directionalLight.position.set(20,20,20)
    @scene.add( directionalLight )

  __floorGeometry: ->
    @floorTexture = new THREE.ImageUtils.loadTexture( 'textures/checkerboard.jpg' )
    @floorTexture.wrapT = THREE.RepeatWrapping
    @floorTexture.wrapS = @floorTexture.wrapT
    @floorTexture.repeat.set( 10, 10 )
    floorMaterial = new THREE.MeshPhongMaterial( { map: @floorTexture, side: THREE.DoubleSide, shading: THREE.FlatShading } )
    floorGeometry = new THREE.PlaneGeometry(100, 100, 10, 10)
    floor = new THREE.Mesh(floorGeometry, floorMaterial)
    floor.position.y = -0.5
    floor.rotation.x = Math.PI / 2
    @scene.add(floor)

  loop:->
    requestAnimationFrame =>
       @loop()
    @update()
    @render()

  render: ->
    @stats.begin()
    @composer.render()
    @stats.end()

  update: ->
    for mesh in @sceneObjs
      mesh.rotation.x += 0.01
      mesh.rotation.y += 0.02

module.exports = MirrorShaderDemo
