THREE = require 'THREE'
Util = require '../behaviors/behaviorUtil.coffee'

class Entity

  behavior:null
  mesh:null
  boundingSize:100
  acceleration:new THREE.Vector3(0,0,0)
  velocity:new THREE.Vector3(0,0,0)

  maxSpeed:2
  minSpeed:0.3
  maxForce:0.05

  constructor: ->
    @

  init:(defaults) ->
    @behavior = defaults.behavior
    @mesh = defaults.mesh
    @boundingSize = defaults.bounding
    @velocity = if defaults.velocity? then defaults.velocity else new THREE.Vector3(0.01,0,0)
    @acceleration = new THREE.Vector3(0.0,0,0)

  update:(objs)->
    @behavior.update(objs)
    @__updateVelocity()
    @__updatePosition()
    @__updateFacing()
    @__loopPosition()
    @__clearAccel()

  __updateVelocity: ->
    @velocity.add(@acceleration)
    @__capVelocity()

  __capVelocity: ->
    @velocity = Util.limit(@velocity, @maxSpeed);

  __clearAccel: ->
    @acceleration = new THREE.Vector3(0,0,0)

  __updatePosition: ->
    @mesh.position.x +=@velocity.x
    @mesh.position.y +=@velocity.y
    @mesh.position.z +=@velocity.z

  __updateFacing: ->
    norm = @velocity.clone()
    norm.normalize();
    @mesh.rotation.x = norm.z
    @mesh.rotation.y = norm.z
    @mesh.rotation.z = norm.z
    #quat = Util.facing(@)
    #@mesh.rotation.setFromQuaternion(quat,'XYZ')

  __loopPosition: ->
    edges = @boundingSize/2
    if @mesh.position.x > edges
      @mesh.position.x = -edges;
    else if @mesh.position.x < -edges
      @mesh.position.x = edges;

    if @mesh.position.y > edges
      @mesh.position.y = -edges;
    else if @mesh.position.y < -edges
      @mesh.position.y = edges;

    if @mesh.position.z > edges
      @mesh.position.z = -edges;
    else if @mesh.position.z < -edges
      @mesh.position.z = edges;

  debugRender: ->

  getPosition: ->
    return @mesh.position

  getVelocity: ->
    return @velocity

  getAcceleration: ->
    return @acceleration



module.exports = Entity