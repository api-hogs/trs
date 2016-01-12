import Ember from 'ember';

export default Ember.Controller.extend({
  session: Ember.inject.service(),

  actions: {

  	save() {
      this.get('project').save();
    },

    deleteProject(project) {
      project.destroyRecord();
    },
    logout: function(){
      this.get('session').invalidate();
    }
  }
});
