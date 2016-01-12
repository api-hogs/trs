import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {

  // OLD

  // this.route('sign_up', { path: '/signup'});

  this.route('resend');
  this.route('confirmation');
  this.route('signin');

  // NEW

  this.route('index', { path: '/' });
  this.route('about');
  this.route('contacts');
  this.route('signin');
  this.route('signup');
  
  this.route('projects', function() {
    this.route('index', { path: '/' }),
    this.route('project', { path: ':project_id' }, function() {
      this.route('language', { path: 'language/:language_id'});
      this.route('edit');
    });
  });

});

export default Router;
