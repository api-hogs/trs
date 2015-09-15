import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('sign_up', { path: '/signup'});
  this.route('projects', function() {
    this.route('project', { path: ':project_id' }, function() {
      this.route('language', { path: 'language/:language_id'});
      this.route('edit');
    });
    this.route('new');
  });
  this.route('signup');
  this.route('resend');
  this.route('confirmation');
  this.route('login');
});

export default Router;
