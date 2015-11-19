import Ember from 'ember';

export default Ember.Controller.extend({
  request: Ember.inject.service(),
  session: Ember.inject.service(),

  actions: {
    saveLanguage: function(){
      let currentProject = this.get('project');
      let language = this.get('language');
      this.get('request').ajax(`/languages/${language.id}/document`, {
        type: 'PUT',
        data: JSON.stringify({
          project: currentProject,
          params: language.data,
          id: language.id
        })
      });
    }
  }
});
