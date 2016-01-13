import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {

  this.route('resend');
  this.route('confirmation');
  this.route('signin');
  this.route('index', { path: '/' });
  this.route('about');
  this.route('contacts');
  this.route('signin');
  this.route('signup');
  this.route('projects', function() {
    this.route('index', { path: '/' }),
    this.route('project', { path: ':project_id'}, function() {
      this.route('language', { path: 'language/:language_id'});
      this.route('edit');
      this.route('show');
    });
  });

});

export default Router;
