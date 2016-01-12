# API Documentation
* [Trs.Api.V1.ProjectsController](#trsapiv1projectscontroller)
  * [create](#trsapiv1projectscontrollercreate)
  * [index](#trsapiv1projectscontrollerindex)
  * [show](#trsapiv1projectscontrollershow)
  * [update](#trsapiv1projectscontrollerupdate)
* [Trs.Api.V1.UsersController](#trsapiv1userscontroller)
  * [create](#trsapiv1userscontrollercreate)

## Trs.Api.V1.ProjectsController
### Trs.Api.V1.ProjectsController.create
* __Method:__ POST
* __Path:__ /api/v1/projects
* __Request body:__
```json
{"data":{"attributes":{"user_id":5,"title":"title"}}}
```
* __Status__: 200
* __Response body:__
```json
{"jsonapi":{"version":"1.0"},"data":{"type":"project","relationships":{"user":{"data":{"type":"users","id":"5"}}},"id":"6","attributes":{"user-id":5,"url":null,"updated-at":"2016-01-12T14:05:17Z","title":"title","inserted-at":"2016-01-12T14:05:17Z","id":6,"description":null,"authentication-tokens":[]}}}
```
### Trs.Api.V1.ProjectsController.index
* __Method:__ GET
* __Path:__ /api/v1/projects
* __Status__: 200
* __Response body:__
```json
{"jsonapi":{"version":"1.0"},"data":[{"type":"project","relationships":{"user":{"data":{"type":"users","id":"2"}}},"id":"2","attributes":{"user-id":2,"url":null,"updated-at":"2016-01-12T14:05:15Z","title":"test","inserted-at":"2016-01-12T14:05:15Z","id":2,"description":null,"authentication-tokens":[]}}]}
```
### Trs.Api.V1.ProjectsController.show
* __Method:__ GET
* __Path:__ /api/v1/projects/400222
* __Status__: 404
* __Response body:__
```json
null
```
### Trs.Api.V1.ProjectsController.update
* __Method:__ PUT
* __Path:__ /api/v1/projects/3
* __Request body:__
```json
{"data":{"attributes":{"title":"title2"}}}
```
* __Status__: 200
* __Response body:__
```json
{"jsonapi":{"version":"1.0"},"data":{"type":"project","relationships":{"user":{"data":{"type":"users","id":"3"}}},"id":"3","attributes":{"user-id":3,"url":null,"updated-at":"2016-01-12T14:05:16Z","title":"title2","inserted-at":"2016-01-12T14:05:16Z","id":3,"description":null,"authentication-tokens":[]}}}
```
## Trs.Api.V1.UsersController
### Trs.Api.V1.UsersController.create
* __Method:__ POST
* __Path:__ /api/v1/users
* __Request body:__
```json
{"data":{"attributes":{"password":"secrets","email":"user@example.com"}}}
```
* __Status__: 200
* __Response body:__
```json
{"jsonapi":{"version":"1.0"},"data":{"type":"users","links":{"self":"api/v1/users/17"},"id":"17","attributes":{"updated-at":"2016-01-12T14:05:22Z","unconfirmed-email":null,"token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl9pZCI6ImpzZlBGUU9pYytaaitGbmJhSFhvaU52dXlDRmNFanBqIiwiaWQiOjE3LCJleHAiOjE0NTMyMTIzMjJ9.mGH3ts5I7H0JIJGEYKJUwmaV-65-7lyz_L7g7DSlgWA","inserted-at":"2016-01-12T14:05:22Z","id":17,"hashed-password-reset-token":null,"hashed-password":"$2b$12$wpA4uQZhXbCPzX8e1Z9haeZoY3MsnlnOziVrBiyRXWsyAJrUsgQGW","hashed-confirmation-token":null,"email":"user@example.com","confirmed-at":"2016-01-12T14:05:22Z","authentication-tokens":[]}}}
```
