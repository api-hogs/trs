import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

export default Ember.Route.extend(AuthenticatedRouteMixin, {
  model(params) {
    return Ember.RSVP.hash({
      project: this.get('store').find('project', params.project_id)
      // languages: ajax('/languages', {data: {project: params.project_id}}).then(payload => {
      //   return payload.languages;
      // })
    });
  },

  setupController(controller, model) {
    controller.setProperties(model);
  }
});
