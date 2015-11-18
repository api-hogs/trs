import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

export default Ember.Route.extend(AuthenticatedRouteMixin, {
  request: Ember.inject.service(''),

  model(params, transition) {
    this.languageId = params.language_id;
    let project = transition.params["projects.project"].project_id;
    let url = `/languages/${params.language_id}?project=${project}`;

    return Ember.RSVP.hash({
      language: this.get('request').ajax(url).then(payload => {
        return {id: params.language_id, data: payload};
      }),
      project: project
    });
  },

  actions: {
  },

  setupController(controller, model) {
    controller.set('language', model.language);
    controller.set('project', model.project);
  }
});
