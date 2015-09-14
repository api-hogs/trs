import Ember from 'ember';
import ajax from 'trs-ember/utils/ajax';

export default Ember.Controller.extend({
  actions: {
    save() {
      const project = this.get('project');
      console.log(project);
      ajax('/projects', {
        type: 'POST',
        data: JSON.stringify({
          params: {},
          id: project.id
        })
      }).then(() => {
        this.transitionToRoute('projects');
      });
    },

    addUser: function(){
      this.get('project.users').pushObject(Ember.Object.create({name: null, token: null}));
    },

    addAdmin: function(){
      this.get('project.admins').pushObject(Ember.Object.create({name: null, token: null}));
    },

    createLanguage: function(language){
      let currentProject = this.get('project');
      ajax(`/languages/${language}`, {
        type: 'POST',
        data: JSON.stringify({
          project: currentProject,
          params: {},
          id: language.id
        })
      });
    }
  }
});

