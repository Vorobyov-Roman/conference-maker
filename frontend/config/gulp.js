'use_strict'

var serverConfig = require('./server.js');

function inReleaseDirectory(path) {
  return serverConfig.releaseDirectory + '/' + path;
}

exports.scripts = {
  source:       'src/scripts/**/*.js',
  watch_source: 'src/scripts/**/*.js',
  destination:  inReleaseDirectory('scripts'),
  message:      'Compiled: Scripts'
}

exports.styles = {
  source:       [
    'src/styles/**/*.sass',
    '!src/styles/**/_*.sass'
  ],
  watch_source: 'src/styles/**/*.sass',
  destination:  inReleaseDirectory('styles'),
  message:      'Compiled: Styles'
}

exports.markup = {
  source:       [
    'src/markup/**/*.jade',
    '!src/markup/{components,components/**}'
  ],
  watch_source: 'src/markup/**/*.jade',
  destination:  inReleaseDirectory(''),
  message:      'Compiled: Markup'
}

exports.vendor = {
  source: {
    jquery: [
      'node_modules/jquery/dist/jquery.js'
    ],
    angular: [
      'node_modules/angular/angular.js',
      'node_modules/angular-route/angular-route.js',
      'node_modules/angular-cookies/angular-cookies.js',
      'node_modules/angular-animate/angular-animate.js',
      'node_modules/angular-jwt/dist/angular-jwt.js',
      'node_modules/angular-ui-bootstrap/dist/ui-bootstrap-tpls.js'
    ],
    bootstrap: [
      'node_modules/bootstrap/dist/css/bootstrap.css',
      'node_modules/bootstrap/dist/js/bootstrap.js'
    ],
    get all() {
      return []
        .concat(this.jquery)
        .concat(this.angular)
        .concat(this.bootstrap);
    }
  },
  destination: inReleaseDirectory('vendor'),
  message:     'Done: Vendor libraries'
}
