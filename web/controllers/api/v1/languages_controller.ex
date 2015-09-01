defmodule Trs.Api.V1.LanguagesController do
  use Trs.Web, :controller

  plug :scrub_params, "project"
  plug :scrub_params, "id" when action in [:show, :update, :delete, :create]
  plug :scrub_params, "params" when action in [:create, :update]

  def index(conn, %{"project" => project}) do
    {body, status_code} = Trs.Couchdb.Utils.get_all_docs(project)
     conn
     |> put_status(status_code)
     |> json body
  end

  def show(conn, %{"project" => project, "id" => id}) do
    {body, status_code} = Trs.Couchdb.Utils.get_doc(project <> "/" <> id)
     conn
     |> put_status(status_code)
     |> json body
  end

  def create(conn, %{"project" => project, "id" => id, "params" => params})do
    {body, status_code} = Trs.Couchdb.Utils.create_doc(project <> "/" <> id, params)
     conn
     |> put_status(status_code)
     |> json body
  end

  def update(conn, %{"project" => project, "id" => id, "params" => params}) do
    {body, status_code} = Trs.Couchdb.Utils.update_doc(project <> "/" <> id, params["key"], params["value"])
     conn
     |> put_status(status_code)
     |> json body
  end

  def delete(conn, %{"id" => id, "project" => project}) do
    {body, status_code} = Trs.Couchdb.Utils.delete_doc(project <> "/#{id}")
     conn
     |> put_status(status_code)
     |> json body
  end

end
