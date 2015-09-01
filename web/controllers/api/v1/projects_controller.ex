defmodule Trs.Api.V1.ProjectsController do
  use Trs.Web, :controller

  plug :scrub_params, "id"
  plug :scrub_params, "params" when action in [:create, :update]

  def show(conn, %{"id" => id}) do
    {body, status_code} = Trs.Couchdb.Utils.get_doc(id <> "/project")
     conn
     |> put_status(status_code)
     |> json body
  end

  def create(conn, %{"id" => id, "params" => params}) do
    Trs.Couchdb.Http.request(:put, id)
    {body, status_code} = Trs.Couchdb.Utils.create_doc(id <> "/project", params)
     conn
     |> put_status(status_code)
     |> json body
  end

  def update(conn, %{"id" => id, "params" => params}) do
    {body, status_code} = Trs.Couchdb.Utils.update_doc(id <> "/project", params)
     conn
     |> put_status(status_code)
     |> json body
  end

  def delete(conn, %{"id" => id}) do
    {body, status_code} = Trs.Couchdb.Utils.delete_doc(id <> "/project")
     conn
     |> put_status(status_code)
     |> json body
  end
end
