import Ember from 'ember';
import ENV from '../config/environment';

export default Ember.Controller.extend({
  queryParams: ['email'],
  email: null,
  inProcess: false,
  actions: {
    sendConfirmation: function () {
      this.set('error', null);
      let self = this;
      //there is no api to resend confirmation link
      let url = `${ENV.adapterUrl}${ENV.adapterNamespace}/users/resend_confirmation`;
      let data = {email: self.email};
      this.set('inProcess', true);
      Ember.$.ajax({
        url: url,
        data: JSON.stringify(data),
        method: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        beforeSend: function(xhr, settings) {
          xhr.setRequestHeader('Accept', settings.accepts.json);
        },
      }).then(function() {
        self.transitionToRoute('/');
      },function (response) {
        //TODO: rework after api will be available.
        if(response.responseJSON.errors.base){
          self.set('error', response.responseJSON.errors.base);
        }
      }).always(function () {
        self.set('inProcess', false);
      });
    }
  }
});
