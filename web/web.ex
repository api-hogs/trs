defmodule Trs.Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use Trs.Web, :controller
      use Trs.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def model do
  end

  def controller do
    quote do
      use Phoenix.Controller

      alias Trs.Repo
      import Trs.Router.Helpers

      def exclude_params, do: ["_rev", "_id", "ok", "id", "rev"]

      def render_json(body, status_code, conn) do
        body = Poison.decode!(body)
        if status_code in 200..299 do
          body = Dict.drop(body, exclude_params)
          conn
            |> put_status(status_code)
            |> json body
        else
          conn
            |> put_status(status_code)
            |> json %{}
        end
      end
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "web/templates"

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import Trs.Router.Helpers
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      alias Trs.Repo
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
