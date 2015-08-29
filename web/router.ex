defmodule Trs.Router do
  use Trs.Web, :router
  @api_scope "/api/v1"

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope @api_scope, Trs do
    pipe_through :api
    put "/languages", Api.V1.LanguagesController, :update
    get "/languages", Api.V1.LanguagesController, :index
    post "/languages", Api.V1.LanguagesController, :create
    delete "/languages", Api.V1.LanguagesController, :destroy
  end
end
