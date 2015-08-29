defmodule Trs.Api.V1.LanguagesControllerTest do
  use Trs.ConnCase

  @project "trs-db"

  setup do
    conn = conn()
            |> put_req_header("accept", "application/json")
            # |> signin_user

    {:ok, conn: conn}
  end

  test "returns all languages for project" do
    create_project!(@project,  "languages", %{languages: [%{title: "en", "description": "English"}]})
    conn = conn
      |> get(languages_path(conn, :index), %{project: @project})

    response = json_api_response(conn, 200)
    delete_project!(@project, "languages")
    assert response["languages"] == [%{"description" => "English", "title" => "en"}]
  end

  test "returns 404 if project not exist" do
    conn = conn
      |> get(languages_path(conn, :index), %{project: "test-missing"})
    assert json_api_response(conn, 404)
  end

  test "creates project with some data" do
    Trs.Couchdb.Http.request(:delete, "trs-my")
    conn = conn
      |> post(languages_path(conn, :create), %{project: "trs-my", params: %{languages: [%{title: "en"}]}})
    assert json_api_response(conn, 201)
  end

  test "updates project" do
    create_project!(@project,  "languages", %{languages: [%{title: "en", "description": "English"}]})
    conn = conn
      |> put("/api/v1/languages", %{project: @project, params: %{languages: [%{title: "gr"}]}})
    assert json_api_response(conn, 201)
    delete_project!(@project, "languages")
  end

  test "delete project" do
    create_project!(@project,  "languages", %{languages: [%{title: "en", "description": "English"}]})
    conn = conn
      |> delete("/api/v1/languages", %{project: @project})
    assert json_api_response(conn, 200)
  end
end
