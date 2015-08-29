defmodule Trs.Api.V1.LanguagesController do
  use Trs.Web, :controller

  plug :scrub_params, "project"
  plug :scrub_params, "id" when action in [:show, :update, :delete, :create]
  plug :scrub_params, "params" when action in [:create, :update]

  def index(conn, %{"project" => project}) do
    %HTTPoison.Response{body: body, status_code: status_code} =
      Trs.Couchdb.Http.get!(project <> "/_all_docs?include_docs=true", [])
    if status_code in 200..399 do

      json conn, get_all_docs(body)
    else
     conn
      |> put_status(404)
      |> json %{}
    end
  end

  def show(conn, %{"project" => project, "id" => id}) do
    %HTTPoison.Response{body: body, status_code: status_code} =
      Trs.Couchdb.Http.get!(project <> "/" <> id, [])
    render_json(body, status_code, conn)
  end

  def create(conn, %{"project" => project, "id" => id, "params" => params})do
    %HTTPoison.Response{body: body, status_code: status_code} =
      Trs.Couchdb.Http.put!(project <> "/" <> id, Poison.encode!(params))
    render_json(body, status_code, conn)
  end

  def update(conn, %{"project" => project, "id" => id, "params" => params}) do
    %HTTPoison.Response{body: body} =
      Trs.Couchdb.Http.get!(project <> "/" <> id, [])
    doc = Poison.decode!(body)
    doc = update_doc(params["key"], params["value"], Dict.drop(doc, ["_id"]))
    %HTTPoison.Response{body: body, status_code: status_code} =
      Trs.Couchdb.Http.put!("#{project}/#{id}}", Poison.encode!(doc))
    render_json(body, status_code, conn)
  end

  def delete(conn, %{"id" => id, "project" => project}) do
    %HTTPoison.Response{body: body} =
      Trs.Couchdb.Http.get!(project <> "/" <> id, [])
    rev = Poison.decode!(body)["_rev"]
    %HTTPoison.Response{body: body, status_code: status_code} =
      Trs.Couchdb.Http.delete!(project <> "/#{id}?rev=#{rev}", [])
    render_json(body, status_code, conn)
  end

  defp update_doc(key, value, doc) do
    deep_update(String.split(key, "."), value, doc)
  end

  defp deep_update([h|[]], value, doc) do
    Dict.put(doc, h, value)
  end

  defp deep_update([h|t], value, doc) do
    Dict.put(doc, h, deep_update(t, value, Dict.fetch!(doc, h)))
  end

  defp deep_update([], _value, doc) do
    doc
  end

  defp get_all_docs(body) do
    Enum.reduce(Poison.decode!(body)["rows"], Map.new, fn(item, acc) ->
      if item["id"] != "project" do
        Map.put(acc, item["doc"]["_id"], Dict.drop(item["doc"], ["_id", "_rev"]))
      else
        acc
      end
    end)
  end

end
