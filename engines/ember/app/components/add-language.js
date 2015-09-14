import Ember from 'ember';

export default Ember.Component.extend({
  value: '',
  isAddForm: false,

  actions: {
    showAddForm: function(){
      this.toggleProperty('isAddForm');
    },

    add: function(){
      if (Ember.isEmpty(this.get('value'))){
        return;
      }
      this.sendAction('createLanguage', this.get('value'));
      this.set('value', '');
      this.toggleProperty('isAddForm');
    }
  }

});
