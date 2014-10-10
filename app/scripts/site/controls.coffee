THREE = require 'threejs'
$ = require 'jquery'

class OrbitalControls extends THREE.EventDispatcher

	EPS:0.000001
	rotateStart:new THREE.Vector2()
	rotateEnd:new THREE.Vector2()
	rotateDelta:new THREE.Vector2()

	panStart:new THREE.Vector2()
	panEnd:new THREE.Vector2()
	panDelta:new THREE.Vector2()

	dollyStart:new THREE.Vector2()
	dollyEnd:new THREE.Vector2()
	dollyDelta:new THREE.Vector2()

	phiDelta:0
	thetaDelta:0
	scale:1
	panVec:new THREE.Vector3(0,0,0)
	lastPosition:new THREE.Vector3(0,0,0)

	STATE:{ NONE : -1, ROTATE : 0, DOLLY : 1, PAN : 2, TOUCH_ROTATE : 3, TOUCH_DOLLY : 4, TOUCH_PAN : 5 }
	state:-1
	changeEvent:{ type: 'change' }

	constructor:(object, domElement, localElement) ->
		console.log 'con last pos', @lastPosition
		@object = object
		@domElement = if domElement?  then domElement else document
		@localElement = if localElement?  then localElement else document

		# Set to false to disable this control
		@enabled = true

		# "target" sets the location of focus, where the control orbits around
		# and where it pans with respect to.
		@target = new THREE.Vector3()
		# center is old, deprecated use "target" instead
		@center = @target

		# This option actually enables dollying in and out left as "zoom" for
		# backwards compatibility
		@noZoom = false
		@zoomSpeed = 1.0
		# Limits to how far you can dolly in and out
		@minDistance = 0
		@maxDistance = Infinity

		# Set to true to disable this control
		@noRotate = false
		@rotateSpeed = 1.0

		# Set to true to disable this control
		@noPan = false
		@keyPanSpeed = 7.0	# pixels moved per arrow key push

		# Set to true to automatically rotate around the target
		@autoRotate = false
		@autoRotateSpeed = 2.0 # 30 seconds per round when fps is 60

		# How far you can orbit vertically, upper and lower limits.
		# Range is 0 to Math.PI radians.
		@minPolarAngle = 0 # radians
		@maxPolarAngle = Math.PI # radians

		# Set to true to disable use of the keys
		@noKeys = false
		# The four arrow keys
		@keys = { LEFT: 37, UP: 38, RIGHT: 39, BOTTOM: 40 }
		@initalizeEvents()
		@

	initalizeEvents: ->
		#this.domElement.addEventListener( 'contextmenu', function ( event ) { event.preventDefault() }, false )

		@localElement.addEventListener( 'mousedown', @onMouseDown, false )
		@domElement.addEventListener( 'mousewheel', @onMouseWheel, false )
		@domElement.addEventListener( 'DOMMouseScroll', @onMouseWheel, false ) # firefox
		@domElement.addEventListener( 'keydown', @onKeyDown, false )

		###
		this.localElement.addEventListener( 'touchstart', touchstart, false )
		this.domElement.addEventListener( 'touchend', touchend, false )
		this.domElement.addEventListener( 'touchmove', touchmove, false )
		###

	rotateLeft:(angle) ->
		if angle is undefined
			angle = @getAutoRotationAngle()

		@thetaDelta -= angle

	rotateUp:(angle) ->
		if angle is undefined
			angle = @getAutoRotationAngle();
		@phiDelta -= angle;

	panLeft:(distance) ->
		panOffset = new THREE.Vector3()
		te = @object.matrix.elements
		#get X column of matrix
		panOffset.set( te[0], te[1], te[2] )
		panOffset.multiplyScalar(-distance)
		@panVec.add( panOffset )

	panUp:(distance) ->
		panOffset = new THREE.Vector3()
		te = @object.matrix.elements
		# get Y column of matrix
		panOffset.set( te[4], te[5], te[6] )
		panOffset.multiplyScalar(distance)
		@panVec.add( panOffset )

	# main entry point pass in Vector2 of change desired in pixel space,
	# right and down are positive
	pan: (delta) ->
		console.log 'pan last pos', @lastPosition
		element = if @domElement is document then @domElement.body else @domElement
		console.log 'domElement', @domElement
		console.log 'element', @element

		if @object.fov?
			#perspective
			position = @object.position
			offset = position.clone().sub(@target)
			targetDistance = offset.length()

			# half of the fov is center to top of screen
			targetDistance *= Math.tan( (@object.fov / 2) * Math.PI / 180.0 )
			# we actually dont use screenWidth, since perspective camera is fixed to screen height
			@panLeft( 2 * delta.x * targetDistance / element.clientHeight )
			@panUp( 2 * delta.y * targetDistance / element.clientHeight )

		else if @object.top?
			#orthographic
			@panLeft( delta.x * (@object.right - @object.left) / element.clientWidth )
			@panUp( delta.y * (@object.top - @object.bottom) / element.clientHeight )

		else
			# camera neither orthographic or perspective - warn user
			console.warn( 'WARNING: OrbitControls.js encountered an unknown camera type - pan disabled.' )

	dollyIn:(dollyScale) ->
		if (dollyScale is  undefined)
			dollyScale = @getZoomScale()
		@scale /= dollyScale

	dollyOut: ->
		if (dollyScale is  undefined)
			dollyScale = @getZoomScale()
		@scale *= dollyScale

	update: ->
		console.log 'update last pos', @lastPosition
		debugger;
		position = @object.position
		offset = position.clone().sub( @target )

		# angle from z-axis around y-axis

		theta = Math.atan2( offset.x, offset.z )

		# angle from y-axis

		phi = Math.atan2( Math.sqrt( offset.x * offset.x + offset.z * offset.z ), offset.y )

		if @autoRotate
			@rotateLeft @getAutoRotationAngle()

		theta += @thetaDelta
		phi += @phiDelta

		# restrict phi to be between desired limits
		phi = Math.max( @minPolarAngle, Math.min( @maxPolarAngle, phi ) )

		# restrict phi to be betwee EPS and PI-EPS
		phi = Math.max( @EPS, Math.min( Math.PI - @EPS, phi ) )

		radius = offset.length() * @scale

		# restrict radius to be between desired limits
		radius = Math.max( @minDistance, Math.min( @maxDistance, radius ) )

		# move target to panned location
		console.log 'pan vec', @panVec
		@target.add( @panVec )

		offset.x = radius * Math.sin( phi ) * Math.sin( theta )
		offset.y = radius * Math.cos( phi )
		offset.z = radius * Math.sin( phi ) * Math.cos( theta )

		position.copy( @target ).add( offset )

		@object.lookAt( @target )

		@thetaDelta = 0
		@phiDelta = 0
		@scale = 1
		@panVec.set(0,0,0)

		console.log 'last pos', @lastPosition
		if @lastPosition.distanceTo( @object.position ) > 0
			@dispatchEvent( @changeEvent )
			@lastPosition.copy( @object.position )

	onMouseDown:( event ) =>
		if @enabled is false
			return

		event.preventDefault()

		if event.button is 0
			if @noRotate is true
				return

			@state = @STATE.ROTATE
			@rotateStart.set(event.clientX, event.clientY)

		else if event.button is 1
			if @noZoom is true
				return
			@state = @STATE.DOLLY
			@dollyStart.set(event.clientX, event.clientY)

		else if event.button is 2
			if @noPan is true
				return

			@state = @STATE.PAN
			@panStart.set(event.clientX, event.clientY)

		# Greggman fix: https://github.com/greggman/three.js/commit/fde9f9917d6d8381f06bf22cdff766029d1761be
		@domElement.addEventListener( 'mousemove', @onMouseMove, false )
		@domElement.addEventListener( 'mouseup', @onMouseUp, false )

	onMouseUp:=>
		if @enabled is false
			return

		# Greggman fix: https://github.com/greggman/three.js/commit/fde9f9917d6d8381f06bf22cdff766029d1761be
		@domElement.removeEventListener( 'mousemove', @onMouseMove, false )
		@domElement.removeEventListener( 'mouseup', @onMouseUp, false )

		@state = @STATE.NONE

	onMouseMove:( event ) =>

		if @enabled is false
			return

		event.preventDefault()
		element = if @domElement is document then @domElement.body else @domElement

		if @state is @STATE.ROTATE
			if @noRotate is true
				return

			@rotateEnd.set( event.clientX, event.clientY )
			@rotateDelta.subVectors( @rotateEnd, @rotateStart )

			# rotating across whole screen goes 360 degrees around
			@rotateLeft( 2 * Math.PI * @rotateDelta.x / element.clientWidth * @rotateSpeed )
			# rotating up and down along whole screen attempts to go 360, but limited to 180
			@rotateUp( 2 * Math.PI * @rotateDelta.y / element.clientHeight * @rotateSpeed )

			@rotateStart.copy(@rotateEnd)

		else if @state is @STATE.DOLLY
			if @noZoom is true
				return

			@dollyEnd.set( event.clientX, event.clientY )
			@dollyDelta.subVectors( @dollyEnd, @dollyStart )

			if @dollyDelta.y > 0
				@dollyIn()
			else
				@dollyOut()

			@dollyStart.copy(@dollyEnd)

		else if @state is @STATE.PAN
			if @noPan is true
				return

			@panEnd.set( event.clientX, event.clientY )
			@panDelta.subVectors( @panEnd, @panStart )
			@pan( @panDelta )
			@panStart.copy( @panEnd )

		# Greggman fix: https://github.com/greggman/three.js/commit/fde9f9917d6d8381f06bf22cdff766029d1761be
		@update()

	onMouseWheel:(event )->
		if @enabled is false or @noZoom is true
			return

		delta = 0

		if event.wheelDelta?
			# WebKit / Opera / Explorer 9
			delta = event.wheelDelta

		else if event.detail?
			# Firefox
			delta = - event.detail

		if delta > 0
			@dollyOut()
		else
			@dollyIn()

	onKeyDown:(event) =>

		if @enabled is false
			return
		if @noKeys is true
			return
		if @noPan is true
			return

		# pan a pixel - I guess for precise positioning?
		# Greggman fix: https://github.com/greggman/three.js/commit/fde9f9917d6d8381f06bf22cdff766029d1761be
		needUpdate = false

		if event.keyCode is @keys.UP
			@pan( new THREE.Vector2( 0, @keyPanSpeed ) )
			needUpdate = true

		else if event.keyCode is @keys.BOTTOM
			@pan( new THREE.Vector2( 0, -@keyPanSpeed ) )
			needUpdate = true

		else if event.keyCode is @keys.LEFT
			@pan( new THREE.Vector2( @keyPanSpeed, 0 ) )
			needUpdate = true

		else if event.keyCode is @keys.RIGHT
			@pan( new THREE.Vector2( -@keyPanSpeed, 0 ) )
			needUpdate = true

		# Greggman fix: https://github.com/greggman/three.js/commit/fde9f9917d6d8381f06bf22cdff766029d1761be
		if needUpdate is true
			@update()

	getZoomScale: ->
		return Math.pow( 0.95, @zoomSpeed )

	getAutoRotationAngle: ->
		return 2 * Math.PI / 60 / 60 * @autoRotateSpeed

module.exports = OrbitalControls