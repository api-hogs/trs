import config from 'trs-ember/config/environment';

export default function() {

  // These comments are here to help you get started. Feel free to delete them.

  /*
    Config (with defaults).

    Note: these only affect routes defined *after* them!
  */
  this.urlPrefix = config.host;
  this.namespace = config.apiNamespace;
  // this.timing = 400;      // delay for each request, automatically set to 0 during testing

  /*
    Routes
  */
  this.get('/projects');
  this.get('/project/:id');

  this.post('/languages/:id/document', () => {
    return {};
  });

  this.delete('/languages/:id', () => {
    return {};
  });

  this.post('/languages/:id', () => {
    return {};
  });

  this.post('/projects', (db, request) => {
    const params = JSON.parse(request.requestBody);
    const newProject = {
      title: params.title,
      users: [],
      admins: []
    };

    return db.projects.insert(newProject);
  });

  this.put('/projects/:id', (db, request) => {
    const params = JSON.parse(request.requestBody);

    return db.projects.update(params.id, {title: params.title});
  });

  this.del('/projects/:id', (db, {params}) => {
    db.projects.remove(params.id);

    return {};
  });

  this.get('/languages');
  this.get('/languages/:id');

}

/*
You can optionally export a config that is only loaded during tests
export function testConfig() {

}
*/
