defmodule Trs.Api.V1.ProjectsControllerTest do
  use Trs.ConnCase
  alias Trs.Project
  alias Trs.User
  alias Trs.Repo


  setup do
    user_tmp = %User{email: "test@test.com", hashed_password: Util.crypto_provider.hashpwsalt("secrets"), confirmed_at: Ecto.DateTime.utc}
      |> Repo.insert!
    token_tmp = Authenticator.generate_token_for(user_tmp)
    project = %Project{title: "test", user_id: user_tmp.id}
      |> Repo.insert!
    conn = conn()
            |> put_req_header("authorization", "Bearer #{token_tmp}")

    {:ok, conn: conn, project: project, user: user_tmp}
  end

  test "returns projects", %{conn: conn} do
    conn = conn
      |> get(projects_path(conn, :index))
      |> doc
    response = json_api_response(conn, 200)
    assert Enum.count(response["data"]) == 1
  end

  test "returns 404 if project not exist", %{conn: conn} do
    conn = conn
      |> get(projects_path(conn, :show, 400222))
      |> doc
    assert conn.status == 404
  end

  test "creates project with some data", %{conn: conn, user: user} do
    conn = conn
      |> post(projects_path(conn, :create), data: %{attributes: %{title: "title", user_id: user.id}})
      |> doc
    assert json_api_response(conn, 200)["data"]["id"]
  end

  test "updates project", %{conn: conn, project: project} do
    conn = conn
      |> put(projects_path(conn, :update, project.id), %{data: %{attributes: %{title: "title2", description: "foo"}}})
      |> doc

    %Project{title: new_title, description: new_description} = Repo.get(Project, project.id)

    assert json_api_response(conn, 200)
    assert new_title == "title2"
    assert new_description == "foo"
  end

  test "delete project", %{conn: conn, project: project} do
    conn
    |> delete(projects_path(conn, :delete, project))

    refute Repo.get(Project, project.id)
  end
end
