defmodule Trs.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  imports other functionality to make it easier
  to build and query models.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest

      alias Trs.Repo

      alias Trs.User
      alias PhoenixTokenAuth.Util
      alias PhoenixTokenAuth.Authenticator

      import Ecto.Model
      import Ecto.Query, only: [from: 2]
      import Trs.Router.Helpers
      import Bureaucrat.Helpers
      # The default endpoint for testing
      @endpoint Trs.Endpoint

      @email "user@example.com"
      @password "secrets"
      @hashed_password Util.crypto_provider.hashpwsalt(@password)

      def signin_user(conn) do
        token = %User{email: @email, hashed_password: @hashed_password, confirmed_at: Ecto.DateTime.utc}
        |> Repo.insert!
        |> Authenticator.generate_token_for

        conn |> put_req_header("authorization", "Bearer #{token}")
      end

      def json_api_response(conn, status) do
        body = response(conn, status)
        case Poison.decode(body) do
          {:ok, body} ->
            body
          {:error, {:invalid, token}} ->
            raise "could not decode JSON body, invalid token #{inspect token} in body:\n\n#{body}"
        end
      end

      def create_document!(db, id, body) do
        path = "#{db}/#{id}"
        Trs.Couchdb.Utils.create_doc(path, body)
      end

    end
  end

  setup tags do
    unless tags[:async] do
      Ecto.Adapters.SQL.restart_test_transaction(Trs.Repo, [])
    end
    :ok
  end
end
