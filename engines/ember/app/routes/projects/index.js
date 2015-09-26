import Ember from 'ember';
import ajax from 'trs-ember/utils/ajax';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

export default Ember.Route.extend(AuthenticatedRouteMixin, {
  model() {
    return ajax('/projects').then(payload => {
      return payload.projects;
    });
  },

  setupController(controller, model) {
    controller.set('projects', model);
  }
});
