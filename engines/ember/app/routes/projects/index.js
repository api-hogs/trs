import Ember from 'ember';
import ajax from 'trs-ember/utils/ajax';

export default Ember.Route.extend({
  model() {
    return ajax('/projects').then(payload => {
      return payload.projects;
    });
  },

  setupController(controller, model) {
    controller.set('projects', model);
  }
});
