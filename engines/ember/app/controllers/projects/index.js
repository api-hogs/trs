import Ember from 'ember';

export default Ember.Controller.extend({
  session: Ember.inject.service(),

  actions: {
    deleteProject(project) {
      project.destroyRecord();
    },
    logout: function(){
      this.get('session').invalidate();
    }
  }
});
