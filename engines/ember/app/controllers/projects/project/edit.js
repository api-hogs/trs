import Ember from 'ember';

export default Ember.Controller.extend({
  request: Ember.inject.service(),
  session: Ember.inject.service(),

  actions: {
    save() {
     this.get('project').save().then(() => {
       this.transitionToRoute('index');
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

