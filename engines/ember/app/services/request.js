import Ember from 'ember';
import config from 'trs-ember/config/environment';

export default Ember.Service.extend({
  session: Ember.inject.service('session'),

  ajax(url, options = {}){
    let fullUrl = `${config.host}/${config.apiNamespace}${url}`;
    let defer = new Ember.RSVP.defer();
    this.get('session').authorize('authorizer:default', (name, value) => {
      let hash = {}; hash[name] = value;
      return Ember.$.ajax({
        url: fullUrl,
        type: options.type || 'GET',
        data: options.data,
        contentType: 'application/json',
        dataType: 'json',
        headers: hash,
        success: defer.resolve
      });
    });
    return defer.promise;
  }
});
