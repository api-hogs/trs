import Mirage from 'ember-cli-mirage';

export default Mirage.Factory.extend({
  title(i) { return `Project ${i}`; },

  users: [
    {name: 'foo', token: 'footoken'},
    {name: 'bar', token: 'bartoken'}
  ],

  admins: [
    {name: 'foo', token: 'footoken'}
  ]

  // name: 'Pete',                         // strings
  // age: 20,                              // numbers
  // tall: true,                           // booleans

  // email: function(i) {                  // and functions
  //   return 'person' + i + '@test.com';
  // },

  // firstName: faker.name.firstName,       // using faker
  // lastName: faker.name.firstName,
  // zipCode: faker.address.zipCode
});
