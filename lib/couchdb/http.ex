defmodule Trs.Couchdb.Http do
  use HTTPoison.Base

  @endpoint "http://localhost:5984/"

  defp process_request_headers(headers) do
    headers ++ [{"Content-Type", "application/json"}]
  end

  defp process_headers(headers) do
    []
    # Enum.into(headers, [])
  end

  defp process_url(url) do
    @endpoint <> url
  end
end

