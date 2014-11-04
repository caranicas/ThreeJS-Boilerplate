THREE = require 'threejs'
$ = require 'jquery'
Orbit = require 'orbitcontrols'
Stats  = require 'stats'

# obnoxious hack around
Physijs = require 'physijs'
Physijs = window.Physijs

DemoInterface = require './DemoInterface'


class PhysiDemo extends DemoInterface

  sceneObjs:[]

  # threeInit: ->
  #   @__initScene()
  #   @__initCamera()
  #   @__initGeometry()
  #   @__initLights()
  #   @__debugStats()

  __initScene: ->
    @scene = new Physijs.Scene()
    @scene.setGravity(new THREE.Vector3( 0, -30, 0 ));
    #@webcan = $('#webgl-canvas');
    #@renderer = new THREE.WebGLRenderer({canvas:@webcan[0]})
    #@renderer.setSize( window.innerWidth, window.innerHeight )

  # __initCamera: ->
  #   @camera = new THREE.PerspectiveCamera( 100, window.innerWidth / window.innerHeight, 1, 10000 )
  #   @camera.position.z = 30
  #   @camera.position.y = 10
  #
  #   controls = new Orbit(@camera);
  #   controls.addEventListener( 'change', @render);

  __initGeometry: ->
    @__initBoxes()
    @__floorGeometry()
    super

  __initBoxes: ->
    cubeGeo = new THREE.CubeGeometry( 5, 5, 5 )
    greyMat = new THREE.MeshLambertMaterial({ color: 0x888888 })
    pinkMat =new THREE.MeshLambertMaterial({ color: 0xff88ff })
    box = new Physijs.BoxMesh(cubeGeo ,greyMat);
    box.position.y = 30;
    @scene.add( box );

    box_material = Physijs.createMaterial(pinkMat,.8,.4)
    boxtwo = new Physijs.BoxMesh(cubeGeo,pinkMat);

    #new Physijs.BoxMesh(cubeGeo,new THREE.MeshLambertMaterial({ color: 0xff00ff }));
    boxtwo.position.y = 10;
    boxtwo.position.x = 3;

    @scene.add( boxtwo );

  __initLights: ->
    directionalLight = new THREE.DirectionalLight( 0x0000ff, 1 )
    directionalLight.position.set( -20, -20, -20)
    @scene.add( directionalLight )
    directionalLight = new THREE.DirectionalLight( 0xffffff, 1 )
    directionalLight.position.set(20,20,20)
    @scene.add( directionalLight )

  __floorGeometry: ->
    textMat = new THREE.MeshLambertMaterial({ map: THREE.ImageUtils.loadTexture( 'images/checkerboard.jpg' ) })
    ground_material = Physijs.createMaterial(textMat,.8,.4)
    ground_material.map.wrapS = ground_material.map.wrapT = THREE.RepeatWrapping
    ground_material.map.repeat.set( 3, 3 )
    ground = new Physijs.BoxMesh(new THREE.CubeGeometry(100, 1, 100),ground_material,0);
    ground.receiveShadow = true;
    @scene.add(ground);


  __update: ->
    @scene.simulate()

module.exports = PhysiDemo
