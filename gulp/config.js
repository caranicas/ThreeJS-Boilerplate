var dest = "./build";
var src = './src';

module.exports = {
  browserSync: {
    server: {
      // We're serving the src folder as well
      // for sass sourcemap linking
      baseDir: [dest, src]
    },
    files: [
      dest + "/**",
      // Exclude Map files
      "!" + dest + "/**.map"
    ]
  },
  stylus: {
    src: src + "/styles/*",
    dest: dest+'/styles'
  },
  images: {
    src: src + "/images/**",
    dest: dest + "/images"
  },
  markup: {
    src: src + "/htdocs/**",
    dest: dest
  },
  browserify: {
    // Enable source maps
    debug: true,
    // Additional file extentions to make optional
    //extensions: ['.coffee', '.hbs'],
    src: ['components/*'],
    // A separate bundle will be generated for each
    // bundle config in the list below
    bundleConfigs: [{
      entries: './src/javascript/app.coffee',
      dest: dest+'/scripts',
      outputName: 'app.js'
    }, {
      entries: './src/javascript/head.coffee',
      dest: dest+'/scripts',
      outputName: 'head.js'
    }]
  }
};
