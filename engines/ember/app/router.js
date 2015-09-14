import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('projects', function() {
    this.route('project', { path: ':project_id' }, function() {
      this.route('language', { path: 'language/:language_id'});
      this.route('edit');
    });

    this.route('new');
  });
});

export default Router;
