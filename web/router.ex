defmodule Trs.Router do
  use Trs.Web, :router
  @api_scope "/api/v1"

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope @api_scope, Trs do
    pipe_through :api
    resources "/projects", Api.V1.ProjectsController
  end
end
