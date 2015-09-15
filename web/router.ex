defmodule Trs.Router do
  use Trs.Web, :router
  require PhoenixTokenAuth

  @api_scope "/api/v1"

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug PhoenixTokenAuth.Plug
  end

  scope @api_scope do
    pipe_through :api

    PhoenixTokenAuth.mount
  end

  scope @api_scope, Trs do
    pipe_through :api
    pipe_through :authenticated

    resources "/projects", Api.V1.ProjectsController
    resources "/languages", Api.V1.LanguagesController
    put "/languages/:id/document", Api.V1.LanguagesController, :document
  end
end
