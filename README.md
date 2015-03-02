ThreeJS-Boilerplate
===================

###Starting point for Three JS App.

- In my personal work I had gotten used to a more modern work flow; a work flow using a component managers and build systems, and treated web development like building a desktop applications. I found working like this not only increased my productivity, but my overall enjoyment of the process as well. When I first attempted to work with [three.js](http://threejs.org/) I found it very difficult to replicate that flow that I had enjoyed so much. I found that I was back to wrangling cats, that the top of my DOM was littered with script tags, and it made me ill. This boiler plate is my is my attempt to harness the power of Three, while still working in a modern way.


####My Bowerable Components
- [Controls](https://github.com/caranicas/ThreeJS-Controls)
- [Effect Composer](https://github.com/caranicas/ThreeJS-EffectComposer)
- [Shaders](https://github.com/caranicas/ThreeJS-Shaders)

* * *

- I didn't want to make to make a repo for each individual threejs component, but Bower has so limitations in how you can include things so it left me with an inconvenient git structure, for both controls and shaders. The Master Branches are essentially Just the readme, and the individual feature branches are where the actual components live. Hopefully In the future I will come up with a more elegant solution but this works for me for the time being.  


####App Structure
- [Backbone](http://backbonejs.org/) for some app structure
- [Browserify](http://browserify.org/) for nice modules.
- [Gulp](http://gulpjs.com/) for fast builds
- [Coffee](http://coffeescript.org/) for clean code
- [Debowerify](https://github.com/eugeneware/debowerify) Ease integration of bower components

####Demo Tech
- [ThreeJS](http://threejs.org/) Web GL Wrapper
- [Stats](https://github.com/mrdoob/stats.js) To make sure you arent chugging along
- [Physijs](https://github.com/chandlerprall/Physijs) - Not well integrated, had to Double assign the physi object inside my demo to get rid of the window object.And had to include add ammo and the worker file in the actual project (not git ignored) and then use a gulp process to move it where it needs to be to build correctly.

####TODOS
- Add Testing
- Better integrate Physijs (potentially fork and make UMD module)
- Add pathing aliasing.
- figure out debowerify a bit better and config pathing.
