defmodule Trs.Api.V1.ProjectsController do
  use Trs.Web, :controller
  alias Trs.Project

  plug :scrub_params, "id" when action in [:show, :update, :delete]
  plug :scrub_params, "data" when action in [:create, :update]

  def index(conn, %{}) do
    user = Repo.preload(conn.assigns.authenticated_user, :projects)
    render(conn, "index.json-api", projects: user.projects)
  end

  def show(conn, %{"id" => id}) do
    record = Repo.get_by(Project, user_id: conn.assigns.authenticated_user.id, id: id)
    if record do
      render(conn, "show.json-api", project: record)
    else
      conn |> put_status(404) |> json nil
    end
  end

  def create(conn, %{"data" => %{"attributes" => params}}) do
    changeset = Project.changeset(%Project{user_id: conn.assigns.authenticated_user.id}, params)
    if changeset.valid? do
      record = Repo.insert!(changeset)
      render(conn, "show.json-api", project: record)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Trs.ChangesetView, "error.json-api", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "data" => %{"attributes" => params}}) do
    record = Repo.get!(Project, id)
    changeset = Project.changeset(record, params)

    if changeset.valid? do
      record = Repo.update!(changeset)
      render(conn, "show.json-api", project: record)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Trs.ChangesetView, "error.json-api", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    record = Repo.get!(Project, id)
    if record.user_id == conn.assigns.authenticated_user.id do
      record = Repo.delete!(record)
      conn
        |> put_status(204)
        |> json nil
    else
      conn
      |> put_status(401)
      |> json nil
    end
  end
end
