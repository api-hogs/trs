import Ember from 'ember';
import UnauthenticatedRouteMixin from 'ember-simple-auth/mixins/unauthenticated-route-mixin';
import ENV from '../config/environment';

export default Ember.Route.extend(UnauthenticatedRouteMixin, {
  beforeModel: function(transition) {

    this._super(transition);
    let self = this;
    transition.then(function() {
      let user = transition.queryParams["user"];
      let token = transition.queryParams["token"];
      if (token && user) {
        let url = `${ENV.adapterUrl}${ENV.adapterNamespace}/users/${user}/confirm`;
        let data = {confirmation_token: token};
        Ember.$.ajax({
          url: url,
          data: JSON.stringify(data),
          method: 'POST',
          dataType: 'json',
          contentType: 'application/json',
          beforeSend: function(xhr, settings) {
            xhr.setRequestHeader('Accept', settings.accepts.json);
          },
        }).then(function(response) {
          token = null;
          if (response) {
            self.get('session').authenticate('authenticator:default', {token: response.token, user_id: response.user_id});
          }
        });
      }
    });
  }
});
