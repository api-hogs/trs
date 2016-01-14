import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

export default Ember.Route.extend(AuthenticatedRouteMixin, {
	
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
