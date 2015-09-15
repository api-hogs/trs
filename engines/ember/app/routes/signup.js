import Ember from 'ember';
import UnauthenticatedRouteMixin from 'ember-simple-auth/mixins/unauthenticated-route-mixin';

export default Ember.Route.extend(UnauthenticatedRouteMixin, {
  beforeModel: function (transition) {
    if(transition.intent.url === '/signup'){
      this._super(transition);
    }
  },
  model: function () {
    return this.get('store').createRecord('user');
  }
});
