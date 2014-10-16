THREE = require 'threejs'
$ = require 'jquery'
Orbit = require 'orbitcontrols'
Stats  = require 'stats'

# obnoxious hack around
Physijs = require 'physijs'
Physijs = window.Physijs



class Demo

  sceneObjs:[]

  threeInit: ->
    @__initScene()
    @__initCamera()
    @__initGeometry()
    @__initLights()
    @__debugStats()
    console.log 'locl obj', Physijs

  __initScene: ->
    @scene = new Physijs.Scene()
    @scene.setGravity(new THREE.Vector3( 0, -30, 0 ));
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
    box = new Physijs.BoxMesh( new THREE.CubeGeometry( 5, 5, 5 ),new THREE.MeshBasicMaterial({ color: 0x888888 }));
    @scene.add( box );
    @sceneObjs.push(box)

  __initLights: ->
    directionalLight = new THREE.DirectionalLight( 0xffffff, 0.5 )
    directionalLight.position.set( -20, -20, -20)
    @scene.add( directionalLight )

    directionalLight = new THREE.DirectionalLight( 0xffffff, 0.5 )
    directionalLight.position.set(20,20,20)
    @scene.add( directionalLight )

  __floorGeometry: ->

    ###
    ground_material = Physijs.createMaterial(
			new THREE.MeshLambertMaterial({ map: THREE.ImageUtils.loadTexture( 'images/rocks.jpg' ) }),
			.8, // high friction
			.4 // low restitution
		);
    ground_material.map.wrapS = ground_material.map.wrapT = THREE.RepeatWrapping
    ground_material.map.repeat.set( 3, 3 )
    ###

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


  ###
  applyForce: ->
    strength = 35, distance, effect, offset, box;

    for ( var i = 0; i < boxes.length; i++ ) {
      box = boxes[i];
      distance = mouse_position.distanceTo( box.position ),
      effect = mouse_position.clone().sub( box.position ).normalize().multiplyScalar( strength / distance ).negate(),
      offset = mouse_position.clone().sub( box.position );
      box.applyImpulse( effect, offset );
  ###

  update: ->
    @scene.simulate()

module.exports = new Demo
