import Ember from 'ember';
import ajax from 'trs-ember/utils/ajax';

export default Ember.Controller.extend({
  actions: {
    save() {
      const project = this.get('project');

      ajax('/projects', {
        type: 'POST',
        data: JSON.stringify(project)
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
      ajax(`/languages/${language}`, {
        type: 'POST',
        data: JSON.stringify({params: {}})
      });
    }
  }
});

