defmodule Trs.PageController do
  use Trs.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
