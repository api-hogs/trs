import Ember from 'ember';
// import ajax from 'trs-ember/utils/ajax';

export default Ember.Controller.extend({
  actions: {
    createLanguage: function(language){
      let currentProject = this.get('project');
      ajax(`/languages/${language}`, {
        type: 'POST',
        data: JSON.stringify({
          project: currentProject,
          params: {},
          id: language.id
        })
      }).then(() => {
        this.get('languages').pushObject({name: language, id: language,  data: {}});
      });
    },

    deleteLanguage: function(language){
      let currentProject = this.get('project');
      ajax(`/languages/${language.id}`, {
        type: 'DELETE',
        data: JSON.stringify({
          project: currentProject
        })
      }).then(() =>{
        this.get('languages').removeObject(language);
      });
    }
  }

});
