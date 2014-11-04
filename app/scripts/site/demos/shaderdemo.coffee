THREE = require 'threejs'
$ = require 'jquery'
Orbit = require 'orbitcontrols'
Stats  = require 'stats'
EffectComposer = require 'effectcomposer'
RenderPass = require 'renderpass'
ShaderPass = require 'shaderpass'
DotScreenShader = require 'dotscreenshader'
RGBShiftShader = require 'rgbshiftshader'

DemoInterface = require './DemoInterface'


class ShaderDemo extends DemoInterface

  sceneObjs:[]

  threeInit: ->
    super
    @__initShader()
    @__createShaderEffects()

  __initShader: ->
    @composer = new EffectComposer( @renderer )
    @composer.addPass( new RenderPass( @scene, @camera ) )

  __createShaderEffects: ->
    effect = new ShaderPass( new DotScreenShader() )
    effect.uniforms[ 'scale' ].value = 4
    @composer.addPass( effect )

    effect = new ShaderPass( new RGBShiftShader())
    effect.uniforms[ 'amount' ].value = 0.0015
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
    @floorTexture = new THREE.ImageUtils.loadTexture( 'images/checkerboard.jpg' )
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

  render: =>
    @stats.begin()
    @composer.render()
    @stats.end()

  update: ->
    for mesh in @sceneObjs
      mesh.rotation.x += 0.01
      mesh.rotation.y += 0.02

module.exports = ShaderDemo
