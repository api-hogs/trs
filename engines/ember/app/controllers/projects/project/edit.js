import Ember from 'ember';
// import ajax from 'trs-ember/utils/ajax';

export default Ember.Controller.extend({
  actions: {
    save() {
     this.get('project').save();
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

