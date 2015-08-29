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
      import Trs.Router.Helpers

      # The default endpoint for testing
      @endpoint Trs.Endpoint

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
        delete_document!(db, id)
        %HTTPoison.Response{body: response, status_code: status_code} =
          Trs.Couchdb.Http.put!(path, Poison.encode!(body))
        Poison.decode!(response)["rev"]
      end

      def delete_document!(db, id, rev) do
        path = "#{db}/#{id}?rev=#{rev}"
        Trs.Couchdb.Http.request(:delete, path)
      end

      def delete_document!(db, id) do
        %HTTPoison.Response{body: body} =
          Trs.Couchdb.Http.get!(db <> "/" <> id, [])
        rev = Poison.decode!(body)["_rev"]
        delete_document!(db, id, rev)
      end
    end
  end

  setup tags do
    :ok
  end
end
