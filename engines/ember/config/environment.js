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
    }
  };

  ENV['ember-simple-auth'] = {
    authorizer: 'authorizer:default',
    session: 'session:default'
  }

  if (environment === 'development') {
    ENV.host = 'http://localhost:4000'

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
    // TODO
    // ENV.host = 'http://some.com'

  }

  return ENV;
};
