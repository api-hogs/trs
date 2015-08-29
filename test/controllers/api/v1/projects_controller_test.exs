defmodule Trs.Api.V1.ProjectsControllerTest do
  use Trs.ConnCase

  @project "trs-db"

  setup do
    conn = conn()
            |> put_req_header("accept", "application/json")
            # |> signin_user

    {:ok, conn: conn}
  end

  test "returns project" do
    create_project!(@project,  "project", %{users: ["token1"]})
    conn = conn
      |> get(projects_path(conn, :show, @project))

    response = json_api_response(conn, 200)
    delete_project!(@project, "project")
    assert response["users"] == ["token1"]
  end

  test "returns 404 if project not exist" do
    conn = conn
      |> get(projects_path(conn, :show, "test-missing"))
    assert json_api_response(conn, 404)
  end

  test "creates project with some data" do
    Trs.Couchdb.Http.request(:delete, "trs-my")
    conn = conn
      |> post(projects_path(conn, :create), %{id: "trs-my", params: %{users: ["token2"]}})
    assert json_api_response(conn, 201)
  end

  test "updates project" do
    create_project!(@project,  "project", %{users: ["token3"]})
    conn = conn
      |> put("/api/v1/projects/#{@project}", %{params: %{users: ["token4"]}})
    delete_project!(@project, "project")
    assert json_api_response(conn, 201)
  end

  test "delete project" do
    create_project!(@project,  "project", %{users: ["token5"]})
    conn = conn
      |> delete("/api/v1/projects/#{@project}")
    assert json_api_response(conn, 200)
  end
end
