import Ember from 'ember';
import ajax from 'trs-ember/utils/ajax';

export default Ember.Route.extend({
  model(params) {
    this.languageId = params.language_id;
    let url = `/languages/${params.language_id}`;

    return ajax(url).then(payload => {
      return payload.language;
    });
  },

  actions: {
    saveLanguage: function(language){
      ajax(`/languages/${this.languageId}/document`, {
        type: 'POST',
        data: JSON.stringify(language.data)
      });
    }
  },

  setupController(controller, model) {
    controller.set('language', model);
  }
});
