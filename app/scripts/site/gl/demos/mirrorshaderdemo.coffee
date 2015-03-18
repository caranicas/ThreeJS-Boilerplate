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

module.exports = MirrorShaderDemo


###




			//Simple three.js mirror shader
			//Using Three.js r.55
			//by Felix Turner - www.airtight.cc

			var camera, scene, renderer;
			var composer;
			var cube;
			var shaderTime = 0;

			var mirrorParams, mirrorPass;


			init();
			animate();

			function init() {

				camera = new THREE.PerspectiveCamera(55, window.innerWidth / window.innerHeight, 20, 3000);
				camera.position.z = 1000;

				scene = new THREE.Scene();

				//Create an image texture
				var imgTexture = THREE.ImageUtils.loadTexture( "../img/sky.jpeg" );
				// imgTexture.wrapS = imgTexture.wrapT = THREE.RepeatWrapping;
				// imgTexture.repeat.set( 10, 10 );
				var imgMaterial = new THREE.MeshBasicMaterial( {
					map : imgTexture
				} );

				//create plane
				var geometry = new THREE.PlaneGeometry(1800*2, 1600,1,1);
				var plane = new THREE.Mesh(geometry, imgMaterial);
				scene.add(plane);
				plane.position.z = - 500;


				//Create an image texture
				var imgTexture2 = THREE.ImageUtils.loadTexture( "../img/testcard.jpg" );
				var imgMaterial2 = new THREE.MeshBasicMaterial( {
					map : imgTexture2
				} );

				//create cube
				var geometry = new THREE.CubeGeometry(500, 500, 500);
				cube = new THREE.Mesh(geometry, imgMaterial2);
				scene.add(cube);

				//init renderer
				renderer = new THREE.WebGLRenderer({});
				renderer.setSize( window.innerWidth, window.innerHeight );

				//add stats
				stats = new Stats();
				stats.domElement.style.position = 'absolute';
				stats.domElement.style.top = '0px';
				container.appendChild( stats.domElement );

				document.body.appendChild( renderer.domElement );

				//POST PROCESSING
				//Create Shader Passes
				//render pass renders scene into effects composer
				var renderPass = new THREE.RenderPass( scene, camera );
				mirrorPass = new THREE.ShaderPass( THREE.MirrorShader );

				//Add Shader Passes to Composer
				//order is important
				composer = new THREE.EffectComposer( renderer);
				composer.addPass( renderPass );
				composer.addPass( mirrorPass );

				//set last pass in composer chain to renderToScreen
				mirrorPass.renderToScreen = true;

				//Init DAT GUI control panel
				mirrorParams = {
					side: 0,
				}

				var gui = new dat.GUI();
				gui.add(mirrorParams, 'side', 0, 3).step(1).onChange(onParamsChange);
				onParamsChange();
			}

			function onParamsChange() {
				//copy gui params into shader uniforms
				mirrorPass.uniforms[ "side" ].value = mirrorParams.side;
			}

			function animate() {
				requestAnimationFrame( animate );
				cube.rotation.y -= 0.01;
				cube.rotation.x += 0.005;
				composer.render( 0.1);
				stats.update();
			}

###
