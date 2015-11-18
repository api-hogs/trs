defmodule Trs.Api.V1.LanguagesController do
  use Trs.Web, :controller
  alias Trs.Project

  plug :scrub_params, "project"
  plug :scrub_params, "id" when action in [:show, :update, :delete, :create]
  plug :scrub_params, "params" when action in [:create, :update]

  def index(conn, %{"project" => project}) do
    record = Repo.get_by(Project, user_id: conn.assigns.authenticated_user.id, id: project)
    {body, status_code} = Trs.Couchdb.Utils.get_all_docs(record.title)
    IO.inspect(status_code)
     conn
     |> put_status(status_code)
     |> json body
  end

  def show(conn, %{"project" => project, "id" => id}) do
    record = Repo.get_by(Project, user_id: conn.assigns.authenticated_user.id, id: project)
    {body, status_code} = Trs.Couchdb.Utils.get_doc(record.title <> "/" <> id)
     conn
     |> put_status(status_code)
     |> json body
  end

  def create(conn, %{"project" => project, "id" => id, "params" => params})do
    record = Repo.get_by(Project, user_id: conn.assigns.authenticated_user.id, id: project)
    {body, status_code} = Trs.Couchdb.Utils.create_doc(record.title <> "/" <> id, params)
     conn
     |> put_status(status_code)
     |> json body
  end

  def update(conn, %{"project" => project, "id" => id, "params" => params}) do
    record = Repo.get_by(Project, user_id: conn.assigns.authenticated_user.id, id: project)
    {body, status_code} = Trs.Couchdb.Utils.update_doc(record.title <> "/" <> id, params["key"], params["value"])
     conn
     |> put_status(status_code)
     |> json body
  end

  def delete(conn, %{"id" => id, "project" => project}) do
    record = Repo.get_by(Project, user_id: conn.assigns.authenticated_user.id, id: project)
    {body, status_code} = Trs.Couchdb.Utils.delete_doc(record.title <> "/#{id}")
     conn
     |> put_status(status_code)
     |> json body
  end

  def document(conn, %{"id" => id, "project" => project, "params" => params}) do
    record = Repo.get_by(Project, user_id: conn.assigns.authenticated_user.id, id: project)
    {body, status_code} = Trs.Couchdb.Utils.update_doc(record.title <> "/" <> id, params)
     conn
     |> put_status(status_code)
     |> json body
  end

end
