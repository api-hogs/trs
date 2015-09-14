import Ember from 'ember';

export default Ember.Component.extend({

  isNotEditing: Ember.computed('user', function(){
    return !Ember.isEmpty(this.get('user.name'));
  }),

  didInsertElement: function(){
    this.get('userCopy');
  },

  userCopy: Ember.computed('user', function(){
    return Ember.Object.create(this.get('user'));
  }),

  actions: {
    edit: function(){
      this.toggleProperty('isNotEditing');
    },

    remove: function(){
      this.get('users').removeObject(this.get('user'));
    },

    cancel: function(){
      this.set('user.name', this.get('userCopy.name'));
      this.set('user.token', this.get('userCopy.token'));
      this.toggleProperty('isNotEditing');
    },

    generateNewToken: function(){
      this.set('user.token', this.rand() + this.rand());
    }
  },

  rand: function(){
    return Math.random().toString(36).substr(2);
  }

});
