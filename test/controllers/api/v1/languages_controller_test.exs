defmodule Trs.Api.V1.LanguagesControllerTest do
  use Trs.ConnCase

  @project "trs-db"

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

  test "return all languages files", %{conn: conn, project: project} do
    create_document!(project.id, "en", %{foo: "bar"})
    create_document!(project.id, "jp", %{foo: "bar1"})

    conn = conn
      |> get(languages_path(conn, :index), %{project: project.id})
      |> doc

    delete_document!(project.id, "en")
    delete_document!(project.id, "jp")
    response = json_api_response(conn, 200)
    assert response["en"]["foo"] == "bar"
    assert response["jp"]["foo"] == "bar1"
  end

  test "gets missing project", %{conn: conn} do
    conn = conn
      |> get(languages_path(conn, :index), %{project: "missing-project"})
      |> doc
    assert json_api_response(conn, 404)
  end

  test "creates new language", %{conn: conn} do
    create_document!(@project,  "project", %{users: ["token1"]})
    conn = conn
      |> post(languages_path(conn, :create), %{project: @project, id: "en", params: %{foo: "bar"}})
      |> doc
    assert json_api_response(conn, 201)
    delete_document!(@project, "project")
    delete_document!(@project, "en")
  end

  test "gets language", %{conn: conn} do
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

  test "updates language", %{conn: conn} do
    create_document!(@project,  "project", %{users: ["token1"]})
    create_document!(@project, "en", %{foo: "bar"})
    conn = conn
      |> put(languages_path(conn, :update, "en"), %{project: @project, params: %{key: "foo", value: "bar1"}})
      |> doc
    delete_document!(@project, "project")
    delete_document!(@project, "en")
    assert json_api_response(conn, 201)
  end

  test "deep updates language", %{conn: conn} do
    create_document!(@project,  "project", %{users: ["token1"]})
    create_document!(@project, "jp", %{foo: %{bar: %{foo: "bar"}}})
    conn = conn
      |> put(languages_path(conn, :update, "jp"), %{project: @project, params: %{key: "foo.bar.foo", value: "bar1"}})
      |> doc
    delete_document!(@project, "project")
    delete_document!(@project, "jp")
    assert json_api_response(conn, 201)
  end

  test "adds new attribute", %{conn: conn} do
    create_document!(@project,  "project", %{users: ["token1"]})
    create_document!(@project, "jp", %{foo: %{bar: %{foo: "bar"}}})
    conn = conn
      |> put(languages_path(conn, :update, "jp"), %{project: @project, params: %{key: "bar", value: "foo"}})
      |> doc
    delete_document!(@project, "project")
    delete_document!(@project, "jp")
    assert json_api_response(conn, 201)
  end

  test "adds deep attribute", %{conn: conn} do
    create_document!(@project,  "project", %{users: ["token1"]})
    create_document!(@project, "jp", %{foo: %{bar: %{foo: "bar"}}})
    conn = conn
      |> put(languages_path(conn, :update, "jp"), %{project: @project, params: %{key: "bar.foo", value: "foo"}})
      |> doc
    delete_document!(@project, "project")
    delete_document!(@project, "jp")
    assert json_api_response(conn, 201)
  end

  test "deletes language", %{conn: conn} do
    create_document!(@project,  "project", %{users: ["token1"]})
    create_document!(@project, "jp", %{foo: %{bar: %{foo: "bar"}}})
    conn = conn
      |> delete(languages_path(conn, :delete, "jp"), %{project: @project})
      |> doc
    assert json_api_response(conn, 200)
  end

  test "document update(bulk)", %{conn: conn} do
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
