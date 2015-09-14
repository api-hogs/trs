import Ember from 'ember';
import ajax from 'trs-ember/utils/ajax';

export default Ember.Controller.extend({
  actions: {
    createLanguage: function(language){
      ajax(`/languages/${language}`, {
        type: 'POST',
        data: JSON.stringify({params: {}})
      }).then(() => {
        this.get('languages').pushObject({name: language, id: language,  data: {}});
      });
    },

    deleteLanguage: function(language){
      ajax(`/languages/${language.id}`, {type: 'DELETE'}).then(() =>{
        this.get('languages').removeObject(language);
      });
    }
  }

});
