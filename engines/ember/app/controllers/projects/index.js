import Ember from 'ember';

export default Ember.Controller.extend({
  session: Ember.inject.service(),
  projectTitle: '',

  isShowingModal: false,
  idToDelete: null,

  actions: {

    setIdToRemove(projectId) {
      this.set('idToDelete', projectId);
    },

  	save() {
      let project = this.store.createRecord('project');
      project.title =  this.get('projectTitle');
      project.save();
      this.set('projectTitle', '');
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
