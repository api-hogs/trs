import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

export default Ember.Route.extend(AuthenticatedRouteMixin, {
  request: Ember.inject.service(),
  model() {
    return this.get('store').findAll('project');
  },

  setupController(controller, model) {
    controller.set('projects', model);
    controller.set('project', this.get('store').createRecord('project'));
  }
});
