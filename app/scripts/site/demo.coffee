THREE = require 'threejs'
$ = require 'jquery'
Orbit = require 'orbitcontrols'
Stats  = require 'stats'


class Demo

  sceneObjs:[]

  threeInit: ->
    @__initScene()
    @__initCamera()
    @__initGeometry()
    @__initLights()
    @__debugStats()


  __initScene: ->
    @scene = new THREE.Scene()
    @webcan = $('#webgl-canvas');
    @renderer = new THREE.WebGLRenderer({canvas:@webcan[0]})
    @renderer.setSize( window.innerWidth, window.innerHeight )

  __initCamera: ->
    @camera = new THREE.PerspectiveCamera( 100, window.innerWidth / window.innerHeight, 1, 10000 )
    @camera.position.z = 30
    @camera.position.y = 10

    controls = new Orbit(@camera);
    controls.addEventListener( 'change', @render);

  __initGeometry: ->
    @__initBoxes()
    @__floorGeometry()
    @__Axis()

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
    floorMaterial = new THREE.MeshBasicMaterial( { map: @floorTexture, side: THREE.DoubleSide } )
    floorGeometry = new THREE.PlaneGeometry(100, 100, 10, 10)
    floor = new THREE.Mesh(floorGeometry, floorMaterial)
    floor.position.y = -0.5
    floor.rotation.x = Math.PI / 2
    @scene.add(floor);

  __Axis: ->
    axes = new THREE.AxisHelper(100);
    @scene.add( axes );

  __debugStats: ->
    @stats = new Stats()
    @stats.setMode(0)
    console.log('@stats', @stats)
    @stats.domElement.style.position = 'absolute';
    @stats.domElement.style.left = '0px';
    @stats.domElement.style.top = '0px';
    document.body.appendChild( @stats.domElement );

  loop:->
    requestAnimationFrame =>
      @loop()
    @update()
    @render()

  render: =>
    @stats.begin()
    @renderer.render( @scene, @camera )
    @stats.end()


  update: ->
    for mesh in @sceneObjs
      mesh.rotation.x += 0.01
      mesh.rotation.y += 0.02

module.exports = new Demo
