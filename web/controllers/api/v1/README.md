# API Documentation
* [Trs.Api.V1.LanguagesController](#trsapiv1languagescontroller)
  * [create](#trsapiv1languagescontrollercreate)
  * [delete](#trsapiv1languagescontrollerdelete)
  * [index](#trsapiv1languagescontrollerindex)
  * [show](#trsapiv1languagescontrollershow)
  * [update](#trsapiv1languagescontrollerupdate)
* [Trs.Api.V1.ProjectsController](#trsapiv1projectscontroller)
  * [create](#trsapiv1projectscontrollercreate)
  * [delete](#trsapiv1projectscontrollerdelete)
  * [show](#trsapiv1projectscontrollershow)
  * [update](#trsapiv1projectscontrollerupdate)

## Trs.Api.V1.LanguagesController
### Trs.Api.V1.LanguagesController.create
* __Method:__ POST
* __Path:__ /api/v1/languages
* __Request body:__
```json
{
  "project": "trs-db",
  "params": {
    "foo": "bar"
  },
  "id": "en"
}
```
* __Status__: 201
* __Response body:__
```json
{}
```
### Trs.Api.V1.LanguagesController.delete
* __Method:__ DELETE
* __Path:__ /api/v1/languages/jp
* __Request body:__
```json
{
  "project": "trs-db"
}
```
* __Status__: 200
* __Response body:__
```json
{}
```
### Trs.Api.V1.LanguagesController.index
* __Method:__ GET
* __Path:__ /api/v1/languages
* __Status__: 404
* __Response body:__
```json
{}
```
* __Method:__ GET
* __Path:__ /api/v1/languages
* __Status__: 200
* __Response body:__
```json
{
  "jp": {
    "foo": "bar1"
  },
  "en": {
    "foo": "bar"
  }
}
```
### Trs.Api.V1.LanguagesController.show
* __Method:__ GET
* __Path:__ /api/v1/languages/en
* __Status__: 200
* __Response body:__
```json
{
  "foo": "bar"
}
```
### Trs.Api.V1.LanguagesController.update
* __Method:__ PUT
* __Path:__ /api/v1/languages/jp
* __Request body:__
```json
{
  "project": "trs-db",
  "params": {
    "value": "foo",
    "key": "bar.foo"
  }
}
```
* __Status__: 201
* __Response body:__
```json
{}
```
* __Method:__ PUT
* __Path:__ /api/v1/languages/en
* __Request body:__
```json
{
  "project": "trs-db",
  "params": {
    "value": "bar1",
    "key": "foo"
  }
}
```
* __Status__: 201
* __Response body:__
```json
{}
```
* __Method:__ PUT
* __Path:__ /api/v1/languages/jp
* __Request body:__
```json
{
  "project": "trs-db",
  "params": {
    "value": "bar1",
    "key": "foo.bar.foo"
  }
}
```
* __Status__: 201
* __Response body:__
```json
{}
```
* __Method:__ PUT
* __Path:__ /api/v1/languages/jp
* __Request body:__
```json
{
  "project": "trs-db",
  "params": {
    "value": "foo",
    "key": "bar"
  }
}
```
* __Status__: 201
* __Response body:__
```json
{}
```
## Trs.Api.V1.ProjectsController
### Trs.Api.V1.ProjectsController.create
* __Method:__ POST
* __Path:__ /api/v1/projects
* __Request body:__
```json
{
  "params": {
    "users": [
      "token2"
    ]
  },
  "id": "trs-my"
}
```
* __Status__: 201
* __Response body:__
```json
{}
```
### Trs.Api.V1.ProjectsController.delete
* __Method:__ DELETE
* __Path:__ /api/v1/projects/trs-db
* __Status__: 200
* __Response body:__
```json
{}
```
### Trs.Api.V1.ProjectsController.show
* __Method:__ GET
* __Path:__ /api/v1/projects/trs-db
* __Status__: 200
* __Response body:__
```json
{
  "users": [
    "token1"
  ]
}
```
* __Method:__ GET
* __Path:__ /api/v1/projects/test-missing
* __Status__: 404
* __Response body:__
```json
{
  "reason": "no_db_file",
  "error": "not_found"
}
```
### Trs.Api.V1.ProjectsController.update
* __Method:__ PUT
* __Path:__ /api/v1/projects/trs-db
* __Request body:__
```json
{
  "params": {
    "users": [
      "token4"
    ]
  }
}
```
* __Status__: 201
* __Response body:__
```json
{}
```
