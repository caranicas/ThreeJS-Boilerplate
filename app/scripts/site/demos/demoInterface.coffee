window.THREE = THREE = require 'threejs'

$ = require 'jquery'
Orbit = require 'orbitcontrols'
Stats  = require 'stats'

class DemoInterface

  sceneObjs:[]
  debugging:false

  constructor: ->
    @debugging = arguments[0].debug

  threeInit: ->
    @__initScene()
    @__initRenderer()
    @__initCamera()
    @__initGeometry()
    @__initLights()
    @__debugStats() if @debugging
    @

  __initScene: ->
    @scene = new THREE.Scene()

  __initRenderer: ->
    @webcan = $('#webgl-canvas')
    @renderer = new THREE.WebGLRenderer({canvas:@webcan[0]})
    @renderer.setSize( window.innerWidth, window.innerHeight )

  __initCamera: ->
    @camera = new THREE.PerspectiveCamera( 100, window.innerWidth / window.innerHeight, 1, 10000 )
    @camera.position.z = 30
    @camera.position.y = 10

    controls = new Orbit(@camera)
    controls.addEventListener( 'change', @render)

  __initGeometry: ->
    @__axis()  if @debugging

  __axis: ->
    axes = new THREE.AxisHelper(100)
    @scene.add( axes )

  __initLights: ->
    directionalLight = new THREE.DirectionalLight( 0xffffff, 0.5 )
    directionalLight.position.set( -20, -20, -20)
    @scene.add( directionalLight )

    directionalLight = new THREE.DirectionalLight( 0xffffff, 0.5 )
    directionalLight.position.set(20,20,20)
    @scene.add( directionalLight )

  __debugStats: ->
    @stats = new Stats()
    @stats.setMode(0)
    @stats.domElement.style.position = 'absolute'
    @stats.domElement.style.left = '0px'
    @stats.domElement.style.top = '0px'
    document.body.appendChild( @stats.domElement )

  loop:->
    requestAnimationFrame =>
      @loop()
    @__update()
    @__render()

  __render: =>
    @stats.begin()
    @renderer.render( @scene, @camera )
    @stats.end()

  __update: ->


module.exports = DemoInterface
