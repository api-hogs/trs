import Ember from 'ember';

export default Ember.Controller.extend({
  request: Ember.inject.service(),
  session: Ember.inject.service(),
  projectName: '',
  projectDesc: '',

  actions: {
    save() {
      let project = this.store.createRecord('project');
      project.set('title', this.get('projectName'));
      project.set('description', this.get('projectDesc'));
      project.save().then(() => {
        this.transitionToRoute('projects.index');
      });
      this.set('projectName', '');
      this.set('projectDesc', '');
    },

    addUser: function(){
      this.get('project.users').pushObject(Ember.Object.create({name: null, token: null}));
    },

    addAdmin: function(){
      this.get('project.admins').pushObject(Ember.Object.create({name: null, token: null}));
    },

    createLanguage: function(language){
      let currentProject = this.get('project');
      this.get('request').ajax(`/languages/${language}`, {
        type: 'POST',
        data: JSON.stringify({
          project_id: currentProject.id,
          params: {},
          id: language.id
        })
      });
    }
  }
});

