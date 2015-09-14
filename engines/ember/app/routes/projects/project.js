import Ember from 'ember';
import ajax from 'trs-ember/utils/ajax';

export default Ember.Route.extend({
  model(params) {
    let projectUrl = `/project/${params.project_id}`;

    return Ember.RSVP.hash({
      project: ajax(projectUrl).then(payload => {
        return payload.project;
      }),
      languages: ajax('/languages', {data: {project_id: params.project_id}}).then(payload => {
        return payload.languages;
      })
    });
  },

  setupController(controller, model) {
    controller.setProperties(model);
  }
});
