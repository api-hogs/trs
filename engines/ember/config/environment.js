/* jshint node: true */

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'trs-ember',
    environment: environment,
    baseURL: '/',
    locationType: 'auto',
    apiNamespace: 'api/v1',
    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. 'with-controller': true
      }
    },

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
    },
    contentSecurityPolicy: {
      'script-src': "'self' 'unsafe-inline' 'unsafe-eval' use.typekit.net http://connect.facebook.net *.googleapis.com " +
        "*.gstatic.com http://localhost:4000 https://maps.googleapis.com https://maxcdn.bootstrapcdn.com *.gstatic.com *.yandex.ru",
      'style-src': "'self' 'unsafe-inline' use.typekit.net *.googleapis.com http://localhost:4000 http://facebook.com https://maxcdn.bootstrapcdn.com",
      'img-src': "*",
      'font-src': "'self' *.gstatic.com https://maxcdn.bootstrapcdn.com",
      'connect-src': "'self' ws://localhost:35729 ws://0.0.0.0:35729 http://localhost:4000",
    }
  };

  ENV['ember-simple-auth'] = {
    authorizer: 'authorizer:abr',
    store: 'session-store:local-storage'
  };

  if (environment === 'development') {

    ENV.host = 'http://localhost:4000'

    ENV.adapterUrl = 'http://localhost:4000';
    ENV.adapterNamespace = "/api/v1";
    // ENV.APP.LOG_RESOLVER = true;
    // ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    // ENV.APP.LOG_VIEW_LOOKUPS = true;
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.baseURL = '/';
    ENV.locationType = 'none';

    ENV.host = 'http://localhost:4000'

    ENV['ember-simple-auth'].crossOriginWhitelist = ['*'];
    ENV['ember-simple-auth-default'] = {
      host: 'http://localhost:4000',
      serverTokenEndpoint: '/api/v1/sessions',
      identificationField : 'email',
      passwordField : 'password',
      refreshAccessTokens: false,
      authorizationHeaderName : 'Authorization',
      authorizationPrefix : 'Bearer ',
      tokenPropertyName: 'token'
    };

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';
  }

  if (environment === 'production') {
    ENV.host = 'http://api.translations.api-hogs.io'
    ENV.adapterUrl - ENV.host;
    ENV.adapterNamespace = "/api/v1";

  }

  return ENV;
};
