defmodule Trs.Api.V1.LanguagesControllerTest do
  use Trs.ConnCase

  @project "trs-db"

  setup do
    conn = conn()
            |> put_req_header("accept", "application/json")
            # |> signin_user

    {:ok, conn: conn}
  end

  test "return all languages files" do
    create_document!(@project,  "project", %{users: ["token1"]})
    create_document!(@project, "en", %{foo: "bar"})
    create_document!(@project, "jp", %{foo: "bar1"})

    conn = conn
      |> get(languages_path(conn, :index), %{project: @project})
      |> doc

    delete_document!(@project, "project")
    delete_document!(@project, "en")
    delete_document!(@project, "jp")
    response = json_api_response(conn, 200)
    assert response["en"]["foo"] == "bar"
    assert response["jp"]["foo"] == "bar1"
  end

  test "gets missing project" do
    conn = conn
      |> get(languages_path(conn, :index), %{project: "missing-project"})
      |> doc
    assert json_api_response(conn, 404)
  end

  test "creates new language" do
    create_document!(@project,  "project", %{users: ["token1"]})
    conn = conn
      |> post(languages_path(conn, :create), %{project: @project, id: "en", params: %{foo: "bar"}})
      |> doc
    assert json_api_response(conn, 201)
    delete_document!(@project, "project")
    delete_document!(@project, "en")
  end

  test "gets language" do
    create_document!(@project,  "project", %{users: ["token1"]})
    create_document!(@project, "en", %{foo: "bar"})
    conn = conn
      |> get(languages_path(conn, :show, "en"), %{project: @project})
      |> doc
    response = json_api_response(conn, 200)
    delete_document!(@project, "project")
    delete_document!(@project, "en")
    assert response["foo"] == "bar"
  end

  test "updates language" do
    create_document!(@project,  "project", %{users: ["token1"]})
    create_document!(@project, "en", %{foo: "bar"})
    conn = conn
      |> put(languages_path(conn, :update, "en"), %{project: @project, params: %{key: "foo", value: "bar1"}})
      |> doc
    delete_document!(@project, "project")
    delete_document!(@project, "en")
    assert json_api_response(conn, 201)
  end

  test "deep updates language" do
    create_document!(@project,  "project", %{users: ["token1"]})
    create_document!(@project, "jp", %{foo: %{bar: %{foo: "bar"}}})
    conn = conn
      |> put(languages_path(conn, :update, "jp"), %{project: @project, params: %{key: "foo.bar.foo", value: "bar1"}})
      |> doc
    delete_document!(@project, "project")
    delete_document!(@project, "jp")
    assert json_api_response(conn, 201)
  end

  test "adds new attribute" do
    create_document!(@project,  "project", %{users: ["token1"]})
    create_document!(@project, "jp", %{foo: %{bar: %{foo: "bar"}}})
    conn = conn
      |> put(languages_path(conn, :update, "jp"), %{project: @project, params: %{key: "bar", value: "foo"}})
      |> doc
    delete_document!(@project, "project")
    delete_document!(@project, "jp")
    assert json_api_response(conn, 201)
  end

  test "adds deep attribute" do
    create_document!(@project,  "project", %{users: ["token1"]})
    create_document!(@project, "jp", %{foo: %{bar: %{foo: "bar"}}})
    conn = conn
      |> put(languages_path(conn, :update, "jp"), %{project: @project, params: %{key: "bar.foo", value: "foo"}})
      |> doc
    delete_document!(@project, "project")
    delete_document!(@project, "jp")
    assert json_api_response(conn, 201)
  end

  test "deletes language" do
    create_document!(@project,  "project", %{users: ["token1"]})
    create_document!(@project, "jp", %{foo: %{bar: %{foo: "bar"}}})
    conn = conn
      |> delete(languages_path(conn, :delete, "jp"), %{project: @project})
      |> doc
    assert json_api_response(conn, 200)
  end

  test "document update(bulk)" do
    create_document!(@project,  "project", %{users: ["token1"]})
    create_document!(@project, "jp", %{foo: %{bar: %{foo: "bar"}}})
    conn = conn
      |> put(languages_path(conn, :document, "jp"), %{project: @project, params: %{foo: "bar2"}})
      |> doc
    delete_document!(@project, "project")
    delete_document!(@project, "jp")
    assert json_api_response(conn, 201)
  end

end
