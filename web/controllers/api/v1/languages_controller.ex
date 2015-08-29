defmodule Trs.Api.V1.LanguagesController do
  use Trs.Web, :controller
  @exclude_params ["_rev", "_id", "ok", "id", "rev"]

  plug :scrub_params, "project"
  plug :scrub_params, "params" when action in [:create, :update]

  def index(conn, %{"project" => project}) do
    %HTTPoison.Response{body: body, status_code: status_code} =
      Trs.Couchdb.Http.get!(project <> "/languages", [])
    render_json(body, status_code, conn)
  end

  def create(conn, %{"project" => project, "params" => params}) do
    Trs.Couchdb.Http.request(:put, project)
    %HTTPoison.Response{body: body, status_code: status_code} =
      Trs.Couchdb.Http.put!(project <> "/languages", Poison.encode!(params))
    render_json(body, status_code, conn)
  end

  def update(conn, %{"project" => project, "params" => params}) do
    %HTTPoison.Response{body: body} =
      Trs.Couchdb.Http.get!(project <> "/languages", [])
    rev = Poison.decode!(body)["_rev"]
    %HTTPoison.Response{body: body, status_code: status_code} =
      Trs.Couchdb.Http.put!("#{project}/languages?rev=#{rev}", Poison.encode!(params))
    render_json(body, status_code, conn)
  end

  def destroy(conn, %{"project" => project}) do
    %HTTPoison.Response{body: body} =
      Trs.Couchdb.Http.get!(project <> "/languages", [])
    rev = Poison.decode!(body)["_rev"]
    %HTTPoison.Response{body: body, status_code: status_code} =
      Trs.Couchdb.Http.delete!(project <> "/languages?rev=#{rev}", [])
    render_json(body, status_code, conn)
  end

  defp render_json(body, status_code, conn) do
    body = Poison.decode!(body)
    if status_code in 200..299 do
      body = Dict.drop(body, @exclude_params)
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
