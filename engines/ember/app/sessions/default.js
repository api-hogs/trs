import Session from 'simple-auth/session';
export default Session.extend({
  currentUser: function() {
    var userId = this.get('secure.user_id');
    if (userId && this.get('isAuthenticated')) {
      return this.container.lookup('store:main').find('user', userId);
    }
  }
});
