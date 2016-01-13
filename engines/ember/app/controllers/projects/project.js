import Ember from 'ember';

export default Ember.Controller.extend({

  langToDelete: null,

  request: Ember.inject.service(),
  session: Ember.inject.service(),

  actions: {

    setLangToRemove(lang) {
      this.set('langToDelete', lang);
    },

    createLanguage: function(){
      let language = this.get('lang');
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
      this.set('lang', '');
    },

    deleteLanguage: function(){
      let currentProject = this.get('project');
      let language = this.get('langToDelete');
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
