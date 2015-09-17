import Ember from 'ember';
import ajax from 'trs-ember/utils/ajax';
import UnauthenticatedRouteMixin from 'ember-simple-auth/mixins/unauthenticated-route-mixin';

export default Ember.Route.extend(UnauthenticatedRouteMixin, {
  model() {
    return ajax('/projects').then(payload => {
      return payload.projects;
    });
  },

  setupController(controller, model) {
    controller.set('projects', model);
  }
});
