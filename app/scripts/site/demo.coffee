THREE = require 'threejs'
$ = require 'jquery'
Orbit = require 'orbitcontrols'


class Demo

  threeInit: ->
    @__initScene()
    @__initCamera()
    @__initGeometry()

  __initScene: ->
    @scene = new THREE.Scene()
    @webcan = $('#webgl-canvas');
    @renderer = new THREE.WebGLRenderer({canvas:@webcan[0]})
    @renderer.setSize( window.innerWidth, window.innerHeight )

  __initCamera: ->
    @camera = new THREE.PerspectiveCamera( 100, window.innerWidth / window.innerHeight, 1, 10000 )
    @camera.position.z = 1000
    controls = new Orbit(@camera);
    controls.addEventListener( 'change', @render);

  __initGeometry: ->
    @geometry = new THREE.BoxGeometry( 200, 200, 200 )
    @material = new THREE.MeshBasicMaterial( { color: 0xff00ff, wireframe: true} )
    @mesh = new THREE.Mesh( @geometry, @material )
    @scene.add(@mesh)

  loop:->
    requestAnimationFrame =>
      @loop()
    @update()
    @render()

  render: =>
    @renderer.render( @scene, @camera )

  update: ->
    @mesh.rotation.x += 0.01
    @mesh.rotation.y += 0.02

module.exports = new Demo
