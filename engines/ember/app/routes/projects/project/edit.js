import Ember from 'ember';

export default Ember.Route.extend({
  setupController(controller) {
    const project = this.modelFor('projects.project').project;

    controller.set('project', project);
  },

  redirect() {
    const model = this.modelFor('projects.project').project;

    if (Ember.isBlank(model)) {
      this.transitionTo('projects');
    }
  }
});
