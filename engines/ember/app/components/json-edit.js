/*global JSONEditor */
import Ember from 'ember';

export default Ember.Component.extend({
  onDidInsertElement: Ember.on('didInsertElement', function(){
    this.setupEditor();
  }),

  setupEditor: function(){
    let container = document.getElementById('json-container');
    this.editor = new JSONEditor(container);
    this.editor.set(this.get('json'));
  },

  onLanguageChange: Ember.observer('language', function(){
    this.editor.set(this.get('json'));
  }),

  actions: {
    save: function(){
      this.set('language.data', this.editor.get());
      this.sendAction('saveLanguage', this.get('language'));
    }
  }
});
