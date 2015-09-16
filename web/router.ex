defmodule Trs.Router do
  use Trs.Web, :router
  require PhoenixTokenAuth

  @api_scope "/api/v1"

  pipeline :api do
    plug :accepts, ["json-api"]
  end

  pipeline :authenticated do
    plug PhoenixTokenAuth.Plug
  end

  scope @api_scope, Trs do
    pipe_through :api
    post  "users",                 Api.V1.UsersController, :create
    post  "users/:id/confirm",     Api.V1.UsersController, :confirm
  end

  scope @api_scope do
    post  "sessions",              PhoenixTokenAuth.Controllers.Sessions, :create
    delete  "sessions",            PhoenixTokenAuth.Controllers.Sessions, :delete
    post  "password_resets",       PhoenixTokenAuth.Controllers.PasswordResets, :create
    post  "password_resets/reset", PhoenixTokenAuth.Controllers.PasswordResets, :reset
    get   "account",               PhoenixTokenAuth.Controllers.Account, :show
    put   "account",               PhoenixTokenAuth.Controllers.Account, :update
  end

  scope @api_scope, Trs do
    pipe_through :api
    pipe_through :authenticated

    resources "/projects", Api.V1.ProjectsController
    resources "/languages", Api.V1.LanguagesController
    put "/languages/:id/document", Api.V1.LanguagesController, :document
  end
end
