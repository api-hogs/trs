import Base from 'ember-simple-auth/authenticators/base';
import Ember from 'ember';
import ENV from '../config/environment';

export default Base.extend({
  sessionTokenEndpoint: `${ENV.adapterUrl}/api/v1/users`,

  restore: function(data) {
    return new Ember.RSVP.Promise(function(resolve, reject) {
      if (!Ember.isEmpty(data.token)) {
        resolve(data);
      } else {
        reject();
      }
    });
  },

  invalidate: function(headers) {
    return new Ember.RSVP.Promise((resolve) => {
      this._makeRequest(this.sessionTokenEndpoint, {}, 'DELETE', headers)
        .always(function() {
        resolve();
       });
    });
  },

  authenticate: function(credentials, headers) {
    return new Ember.RSVP.Promise((resolve, reject) => {
      if (credentials.token) {
        return resolve(credentials);
      }
      this._makeRequest(this.tokenEndpoint, credentials, 'POST', headers)
      .then(function(response)  {
        resolve({token: response.token, userId: response.user.id});
      }, function(xhr) {
        Ember.run(null, reject, xhr.responseJSON || xhr.responseText);
      });
    });
  },

  _makeRequest(url, data, type = 'POST', headers = {}){
    return Ember.$.ajax({
      url:         url,
      type:        type,
      data:        JSON.stringify(data),
      contentType: 'application/json',
      headers: headers
    });
  }
});
