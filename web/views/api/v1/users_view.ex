defmodule Trs.Api.V1.UsersView do
  use Trs.Web, :view

  alias Trs.Api.V1.UserSerializer

  def render("index.json-api", %{users: users}) do
    users
    |> UserSerializer.format
  end

  def render("show.json-api", %{user: user}) do
    user
    |> UserSerializer.format
  end

end
