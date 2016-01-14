defmodule Trs.Api.V1.LanguagesControllerTest do
  use Trs.ConnCase
  alias Trs.Project
  alias Trs.User
  alias Trs.Repo
  alias Trs.Utils

  @project_title "title"

  setup do
    user_tmp = %User{email: "test@test.com", hashed_password: Util.crypto_provider.hashpwsalt("secrets"), confirmed_at: Ecto.DateTime.utc}
      |> Repo.insert!
    token_tmp = Authenticator.generate_token_for(user_tmp)
    project = %Project{title: @project_title, user_id: user_tmp.id, couchdb_name: Utils.snake_case_title(@project_title)}
      |> Repo.insert!

    Trs.Couchdb.Http.request(:delete, project.couchdb_name)
    Trs.Couchdb.Http.request(:put, project.couchdb_name)

    conn = conn()
            |> put_req_header("authorization", "Bearer #{token_tmp}")

    {:ok, conn: conn, project: project, user: user_tmp}
  end

  test "return all languages files", %{conn: conn, project: project} do
    create_document!(project.title, "en", %{foo: "bar"})
    create_document!(project.title, "jp", %{foo: "bar1"})

    conn = conn
      |> get(languages_path(conn, :index), %{project: project.id})
      |> doc

    response = json_api_response(conn, 200)
    assert response["en"]["foo"] == "bar"
    assert response["jp"]["foo"] == "bar1"
  end

  test "creates new language", %{conn: conn, project: project} do
    create_document!(project.title,  "project", %{users: ["token1"]})
    conn = conn
      |> post(languages_path(conn, :create), %{project: project.id, id: "en", params: %{foo: "bar"}})
      |> doc
    assert json_api_response(conn, 201)
  end

  test "gets language", %{conn: conn, project: project} do
    create_document!(project.title, "en", %{foo: "bar"})
    conn = conn
      |> get(languages_path(conn, :show, "en"), %{project: project.id})
      |> doc
    response = json_api_response(conn, 200)
    assert response["foo"] == "bar"
  end

  test "updates language", %{conn: conn, project: project} do
    create_document!(project.title, "en", %{foo: "bar"})
    conn = conn
      |> put(languages_path(conn, :update, "en"), %{project: project.id, params: %{key: "foo", value: "bar1"}})
      |> doc
    assert json_api_response(conn, 201)
  end

  test "deep updates language", %{conn: conn, project: project} do
    create_document!(project.title, "jp", %{foo: %{bar: %{foo: "bar"}}})
    conn = conn
      |> put(languages_path(conn, :update, "jp"), %{project: project.id, params: %{key: "foo.bar.foo", value: "bar1"}})
      |> doc
    assert json_api_response(conn, 201)
  end

  test "adds new attribute", %{conn: conn, project: project} do
    create_document!(project.title, "jp", %{foo: %{bar: %{foo: "bar"}}})
    conn = conn
      |> put(languages_path(conn, :update, "jp"), %{project: project.id, params: %{key: "bar", value: "foo"}})
      |> doc
    assert json_api_response(conn, 201)
  end

  test "adds deep attribute", %{conn: conn, project: project} do
    create_document!(project.title, "jp", %{foo: %{bar: %{foo: "bar"}}})
    conn = conn
      |> put(languages_path(conn, :update, "jp"), %{project: project.id, params: %{key: "bar.foo", value: "foo"}})
      |> doc
    assert json_api_response(conn, 201)
  end

  test "deletes language", %{conn: conn, project: project} do
    create_document!(project.title, "jp", %{foo: %{bar: %{foo: "bar"}}})
    conn = conn
      |> delete(languages_path(conn, :delete, "jp"), %{project: project.id})
      |> doc
    assert json_api_response(conn, 200)
  end

  test "document update(bulk)", %{conn: conn, project: project} do
    create_document!(project.title, "jp", %{foo: %{bar: %{foo: "bar"}}})
    conn = conn
      |> put(languages_path(conn, :document, "jp"), %{project: project.id, params: %{foo: "bar2"}})
      |> doc
    assert json_api_response(conn, 201)
  end
end
