import Ember from 'ember';

export default Ember.Controller.extend({
  request: Ember.inject.service(),
  session: Ember.inject.service(),

  actions: {
    createLanguage: function(language){
      let currentProject = this.get('project');
      this.get('request').ajax(`/languages`, {
        type: 'POST',
        data: JSON.stringify({
          project: currentProject.id,
          params: {title: language},
          id: language
        })
      }).then(() => {
        this.get('languages').pushObject({name: language, id: language,  data: {}});
      });
    },

    deleteLanguage: function(language){
      let currentProject = this.get('project');
      this.get('request').ajax(`/languages/${language.title}`, {
        type: 'DELETE',
        data: JSON.stringify({
          project: currentProject.id
        })
      }).then(() =>{
        this.get('languages').removeObject(language);
      });
    }
  }

});
