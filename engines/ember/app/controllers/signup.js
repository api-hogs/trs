import Ember from 'ember';

export default Ember.Controller.extend({
  inProcess : false,

  session: Ember.inject.service('session'),

  withDefault: function() {
    return this.get('model').save().then((user)=>{
      return this.get('session').authenticate('authenticator:default', {token: user.get('token'), user_id: user.id});
    },function (fail) {
      Ember.Logger.debug(fail);
    });
  },
  actions: {
    signup: function (action) {
      this.set('inProcess', true);
      this[action]().then(()=>{
        this.get('model').save();
      },()=>{
        //for error
      }).finally(() => {
        this.set('inProcess', false);
      });
    }
  }
});