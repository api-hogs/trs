import Ember from 'ember';

export default Ember.Controller.extend({
  
  actions: {

    sendContact() {
      console.log("wokrs");
      console.log(this.get('model'));
    }

  }

});
