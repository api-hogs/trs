import Ember from 'ember';
// import ajax from 'trs-ember/utils/ajax';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

export default Ember.Route.extend(AuthenticatedRouteMixin, {
  model(params) {
    this.languageId = params.language_id;
    let url = `/languages/${params.language_id}`;

    return ajax(url, {data: {project: params.project}}).then(payload => {
      return payload.language;
    });
  },

  actions: {
    saveLanguage: function(language){
      let currentProject = this.get('project');
      ajax(`/languages/${this.languageId}/document`, {
        type: 'POST',
        data: JSON.stringify({
          project: currentProject,
          params: language.data,
          id: language.id
        })
      });
    }
  },

  setupController(controller, model) {
    controller.set('language', model);
  }
});
