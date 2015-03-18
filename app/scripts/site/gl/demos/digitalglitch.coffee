THREE = require 'threejs'

EffectComposer = require 'effectcomposer'
DigitalGlitchShader = require 'digitalglitch'

DemoInterface = require './DemoInterface'

class DotShaderDemo extends DemoInterface


  threeInit: ->
    super
    @__initShader()
    @__createShaderEffects()

  __initShader: ->
    console.log('composer', EffectComposer)
    @composer = new EffectComposer( @renderer )
    @composer.addPass( new EffectComposer.prototype.RenderPass( @scene, @camera ) )

  __createShaderEffects: ->
    effect = new EffectComposer.prototype.ShaderPass( new DigitalGlitchShader() )
    effect.uniforms[ "amount" ].value = 0.008
    #effect.uniforms[ "angle" ].value = .02
    effect.uniforms[ "seed" ].value = 1
    effect.uniforms[ "seed_x" ].value = 0.3
    effect.uniforms[ "seed_y" ].value = 1
    # effect.uniforms[ "distortion_x" ].value = 1
    # effect.uniforms[ "distortion_y" ].value = 1
    # effect.uniforms[ "col_s" ].value = 1
    ###
    "amount": {
      type: "f",
      value: 0.08
    },
    "angle": {
      type: "f",
      value: 0.02
    },
    "seed": {
      type: "f",
      value: 0.02
    },
    "seed_x": {
      type: "f",
      value: 0.02
    },
    "seed_y": {
      type: "f",
      value: 0.02
    },
    "distortion_x": {
      type: "f",
      value: 0.5
    },
    "distortion_y": {
      type: "f",
      value: 0.6
    },
    "col_s": {
      type: "f",
      value: 0.05
    ###
    effect.renderToScreen = true
    @composer.addPass( effect )

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


  # if I don't reimplement loop then the basic implementation of render gets called,
  # not the shader implementation so i need to do this.
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

module.exports = DotShaderDemo
