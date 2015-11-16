import Base from 'ember-simple-auth/authorizers/base';
import Ember from 'ember';

const { isEmpty } = Ember;

export default Base.extend({
  authorize: function(data, block) {
    const tokenAttributeName = 'token';
    const userToken = data[tokenAttributeName];
    if (!isEmpty(userToken)) {
      block('Authorization', `Bearer ${userToken}`);
    }
  },

  authorizeWithToken: function(data, block) {
    return this.authorize(data, (name, value) => {
      let hash = {}; hash[name] = value;
      block(hash);
    });
  }

});

