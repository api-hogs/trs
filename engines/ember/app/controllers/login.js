import Ember from 'ember';

export default Ember.Controller.extend({
  inProcess: false,
  withDefault: function() {
    let credentials = this.getProperties('identification', 'password');
    return this.get('session').authenticate('authenticator:default', credentials).catch((reason) => {
      this.set('error', reason.errors.base);
    });
  },
  actions: {
    authenticate: function(action) {
      this.set('inProcess', true);
      this[action]().finally(() => {
        this.set('inProcess', false);
      });
    }
  }
});
