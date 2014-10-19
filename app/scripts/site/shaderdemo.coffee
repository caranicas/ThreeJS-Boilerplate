THREE = require 'threejs'
$ = require 'jquery'
Orbit = require 'orbitcontrols'
Stats  = require 'stats'
EffectComposer = require 'effectcomposer'
RenderPass = require 'renderpass'
ShaderPass = require 'shaderpass'
DotScreenShader = require 'dotscreenshader'

class ShaderDemo

  sceneObjs:[]

  threeInit: ->
    @__initScene()
    @__initCamera()
    @__initGeometry()
    @__initLights()
    @__initShader()
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
    #@__floorGeometry()
    #@__Axis()

  __initBoxes: ->
    @geometry = new THREE.BoxGeometry( 5, 5, 5 )

    @material = new THREE.ShaderMaterial( { color: 0xff00ff, shading: THREE.FlatShading } );
    #@material = new THREE.MeshLambertMaterial( { color: 0xff00ff, wireframe: false} )
    @mesh = new THREE.Mesh( @geometry, @material )
    @mesh.position.y = 10
    @mesh.position.x = 5
    @scene.add(@mesh)
    @sceneObjs.push(@mesh)

    ###
    @geometry = new THREE.BoxGeometry( 5, 5, 5 )
    @material = new THREE.MeshPhongMaterial( { color: 0xffff00, shading: THREE.FlatShading } );
    #@material = new THREE.MeshLambertMaterial( { color: 0xffff00, wireframe: false} )
    @mesh = new THREE.Mesh( @geometry, @material )
    @mesh.position.y = 10
    @mesh.position.x = -5
    @scene.add(@mesh)
    @sceneObjs.push(@mesh)
    ###



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
    @scene.add(floor);

  __Axis: ->
    axes = new THREE.AxisHelper(100);
    @scene.add( axes );


  __initShader: ->
    @composer = new EffectComposer( @renderer );
    @composer.addPass( new RenderPass( @scene, @camera ) );
    effect = new ShaderPass( new DotScreenShader() );
    effect.uniforms[ 'scale' ].value = 4;
    @composer.addPass( effect );
    #effect = new THREE.ShaderPass( THREE.RGBShiftShader );
    #effect.uniforms[ 'amount' ].value = 0.0015;
    #effect.renderToScreen = true;
    #@composer.addPass( effect );

  __debugStats: ->
    @stats = new Stats()
    @stats.setMode(0)
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
    @composer.render()
    @renderer.render( @scene, @camera )
    @stats.end()


  update: ->
    for mesh in @sceneObjs
      mesh.rotation.x += 0.01
      mesh.rotation.y += 0.02

module.exports = new ShaderDemo
