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
      this._makeRequest(this.get('sessionTokenEndpoint'), {}, 'DELETE', headers)
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
      credentials.email = credentials.identification;
      this._makeRequest(`${ENV.host}/api/v1/sessions`, credentials, 'POST', headers)
      .then(function(response)  {
        resolve({token: response.token});
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
