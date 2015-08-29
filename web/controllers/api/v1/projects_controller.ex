defmodule Trs.Api.V1.ProjectsController do
  use Trs.Web, :controller

  plug :scrub_params, "id"
  plug :scrub_params, "params" when action in [:create, :update]

  def show(conn, %{"id" => id}) do
    %HTTPoison.Response{body: body, status_code: status_code} =
      Trs.Couchdb.Http.get!(id <> "/project", [])
    render_json(body, status_code, conn)
  end

  def create(conn, %{"id" => id, "params" => params}) do
    Trs.Couchdb.Http.request(:put, id)
    %HTTPoison.Response{body: body, status_code: status_code} =
      Trs.Couchdb.Http.put!(id <> "/project", Poison.encode!(params))
    render_json(body, status_code, conn)
  end

  def update(conn, %{"id" => id, "params" => params}) do
    %HTTPoison.Response{body: body} =
      Trs.Couchdb.Http.get!(id <> "/project", [])
    rev = Poison.decode!(body)["_rev"]
    %HTTPoison.Response{body: body, status_code: status_code} =
      Trs.Couchdb.Http.put!("#{id}/project?rev=#{rev}", Poison.encode!(params))
    render_json(body, status_code, conn)
  end

  def delete(conn, %{"id" => id}) do
    %HTTPoison.Response{body: body} =
      Trs.Couchdb.Http.get!(id <> "/project", [])
    rev = Poison.decode!(body)["_rev"]
    %HTTPoison.Response{body: body, status_code: status_code} =
      Trs.Couchdb.Http.delete!(id <> "/project?rev=#{rev}", [])
    render_json(body, status_code, conn)
  end
end
