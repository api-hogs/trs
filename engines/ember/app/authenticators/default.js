import Ember from 'ember';
import Base from 'ember-simple-auth/authenticators/base';
import config from '../config/environment';

var Config = config['ember-simple-auth-default'];

export default Base.extend({

  init: function() {
    this.serverTokenEndpoint = Config.serverTokenEndpoint || '';
    this.host = Config.host || '';
    this.identificationField = Config.identificationField || 'username';
    this.passwordField = Config.passwordField || 'password';
    this.tokenPropertyName = Config.tokenPropertyName || 'token';
    this.headers = Config.headers || {};
  },


  restore: function(properties) {
    let self = this,
        propertiesObject = Ember.Object.create(properties);

    return new Ember.RSVP.Promise(function(resolve, reject) {
      if (!Ember.isEmpty(propertiesObject.get(self.tokenPropertyName))) {
        resolve(properties);
      } else {
        reject();
      }
    });
  },

  authenticate: function(credentials) {
    let self = this;
    return new Ember.RSVP.Promise(function(resolve, reject) {
      if(!Ember.isEmpty(credentials.token)){
        return resolve(credentials);
      }
      let data = self.getAuthenticateData(credentials);
      self.makeRequest(data).then(function(response) {
        Ember.run(function() {
          resolve(self.getResponseData(response));
        });
      }, function(xhr) {
        Ember.run(function() {
          reject(xhr.responseJSON || xhr.responseText);
        });
      });
    });
  },

  getAuthenticateData: function(credentials) {
    let authentication = {};
    authentication[this.passwordField] = credentials.password;
    authentication[this.identificationField] = credentials.identification;
    return authentication;
  },

  getResponseData: function(response) {
    return response;
  },

  invalidate: function() {
    let self  = this;
    return new Ember.RSVP.Promise(function(resolve, reject) {
      Ember.$.ajax({
          method: "DELETE",
          url: self.getUrl(),
        }).then(function(){
          return resolve();
        }, function () {
          Ember.Logger.log('unsuccessed!!!');
          return reject();
        });
    });
  },

  makeRequest: function(data) {
    let self  = this;
    return Ember.$.ajax({
      url: self.getUrl(),
      method: 'POST',
      data: JSON.stringify(data),
      dataType: 'json',
      contentType: 'application/json',
      beforeSend: function(xhr, settings) {
        xhr.setRequestHeader('Accept', settings.accepts.json);
      },
      headers: this.headers
    });
  },

  getUrl : function () {
    return `${this.host}${this.serverTokenEndpoint}`;
  }
});
