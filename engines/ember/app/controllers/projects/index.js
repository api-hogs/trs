import Ember from 'ember';
import ajax from 'trs-ember/utils/ajax';

export default Ember.Controller.extend({
  actions: {
    deleteProject(project) {
      let projectId = Ember.get(project, 'id');
      let url = `/projects/${projectId}`;

      ajax(url, {
        type: 'DELETE'
      }).then(() => {
        let projects = this.get('projects');

        projects.removeObject(project);
      });
    }
  }
});
