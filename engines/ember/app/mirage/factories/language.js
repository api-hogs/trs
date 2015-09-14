import Mirage from 'ember-cli-mirage';

export default Mirage.Factory.extend({
  name(i) { return `en${i}`; },
  data(i) {
    return {
      foo: `foo ${i}`,
      bar: `bar ${i}`
    };
  }
});
