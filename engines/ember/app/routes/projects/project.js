import Ember from 'ember';
import ajax from 'trs-ember/utils/ajax';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

export default Ember.Route.extend(AuthenticatedRouteMixin, {
  model(params) {

    let projectUrl = `/project/${params.project_id}`;

    return Ember.RSVP.hash({
      project: ajax(projectUrl).then(payload => {
        return payload.project;
      }),
      languages: ajax('/languages', {data: {project: params.project}}).then(payload => {
        return payload.languages;
      })
    });
  },

  setupController(controller, model) {
    controller.setProperties(model);
  }
});
