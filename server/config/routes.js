console.log("server routes");
/* require controller file */
var users = require('../controllers/users.js');
var individuals = require('../controllers/individuals.js');

module.exports = function(app) {
  /* CRUD routes for users, only needed ones */
  app.get('/users', users.index);
  app.get('/users/:id', users.show);
  app.post('/users', users.create);

  /* CRUD routes for individuals */
  app.get('/individuals', individuals.index);
  app.get('/individuals/:id', individuals.show);
  app.post('/individuals', individuals.create);
}

