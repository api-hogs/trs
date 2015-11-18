import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

export default Ember.Route.extend(AuthenticatedRouteMixin, {
  request: Ember.inject.service(),

  model(params) {
    return Ember.RSVP.hash({
      project: this.get('store').find('project', params.project_id),
      languages: this.get('request').ajax('/languages', {data: {project: params.project_id}}).then(payload => {
        let data = [];
        Object.keys(payload).forEach((key) => {
          data.push({id: key, data: payload[key] || {}});
        });
        return data;
      })
    });
  },

  setupController(controller, model) {
    controller.setProperties(model);
  }
});
