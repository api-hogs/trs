/* global require, module */
var EmberApp = require('ember-cli/lib/broccoli/ember-app');
var pickFiles = require('broccoli-static-compiler');
var mergeTrees = require('broccoli-merge-trees');

module.exports = function(defaults) {
  var app = new EmberApp(defaults, {
    sassOptions: {
      includePaths: ['app/styles']
    }
    // Add options here
  });

  app.import(app.bowerDirectory + '/bootstrap/dist/css/bootstrap.min.css');
  app.import(app.bowerDirectory + '/bootstrap/dist/css/bootstrap-theme.min.css');
  app.import(app.bowerDirectory + '/bootstrap/dist/js/bootstrap.min.js');
  app.import(app.bowerDirectory + '/jsoneditor/dist/jsoneditor.js');
  app.import(app.bowerDirectory + '/jsoneditor/dist/jsoneditor.css');

  var bootstrapFonts = pickFiles('bower_components/bootstrap/fonts', {
    srcDir: '/',
    destDir: '/fonts'
  });

  var icons = pickFiles('bower_components/jsoneditor/dist/img', {
    srcDir: '/',
    destDir: '/assets/img'
  });

  return mergeTrees([app.toTree(), bootstrapFonts, icons]);
};
