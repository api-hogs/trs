import Ember from 'ember';
import Base from 'ember-simple-auth/authorizers/base';
import config from '../config/environment';

var Config = config['simple-auth-default'];

export default Base.extend({
  authorizationPrefix: 'Bearer ',

  tokenPropertyName: 'token',

  authorizationHeaderName: 'Authorization',

  init: function() {
    this.tokenPropertyName = Config.tokenPropertyName;
    this.authorizationHeaderName = Config.authorizationHeaderName;

    if (Config.authorizationPrefix || Config.authorizationPrefix === null) {
      this.authorizationPrefix = Config.authorizationPrefix;
    }
  },

  authorize: function(jqXHR) {
    let token = this.buildToken();

    if (this.get('session.isAuthenticated') && !Ember.isEmpty(token)) {
      if(this.authorizationPrefix) {
        token = this.authorizationPrefix + token;
      }

      jqXHR.setRequestHeader(this.authorizationHeaderName, token);
    }
  },

  buildToken: function() {
    return this.get('session.secure.' + this.tokenPropertyName);
  }
});
