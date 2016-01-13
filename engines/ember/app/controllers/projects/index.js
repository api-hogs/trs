import Ember from 'ember';

export default Ember.Controller.extend({
  session: Ember.inject.service(),
  project: null,

  isShowingModal: false,
  idToDelete: null,

  actions: {

    createRecord: function() {
      let project = this.store.createRecord('project');
      this.set('project', project);
    },

    setIdToRemove(projectId) {
      this.set('idToDelete', projectId);
    },

  	save() {
      this.get('project').save();
    },

    deleteProject: function() {
      let project = this.store.peekRecord('project', this.get('idToDelete'));
      project.destroyRecord();
    },

    logout: function(){
      this.get('session').invalidate();
    }
  }
});
