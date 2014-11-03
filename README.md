ThreeJS-Boilerplate
===================

Starting point for Three JS App.

-- App Structure
- [Backbone](http://backbonejs.org/) for some app structure
- [Browserify](http://browserify.org/) for nice modules.
- [Gulp](http://gulpjs.com/) for fast builds
- [Coffee](http://coffeescript.org/) for clean code
- [Debowerify](https://github.com/eugeneware/debowerify) Ease integration of bower components

-- Demo Tech
- [ThreeJS](http://threejs.org/) Web GL Wrapper
- [Stats](https://github.com/mrdoob/stats.js) To make sure you arent chugging along
- [OrbitControls](https://github.com/caranicas/threejs-components/tree/orbitcontrols) from my component repo pulled in through bower.
- [Physijs](https://github.com/chandlerprall/Physijs) - Not well integrated, Had to manually add require threejs to the top of the file and double assign inside my demo to get rid of the window object, as well as make special expections for ammojs and physijs_worker.

-- Todo
- Add Testing
- Better integrate Physijs (potentially fork and make UMD module)
- Add pathing aliasing.
- figure out debowerify a bit better and config pathing.
- basic routing between examples
