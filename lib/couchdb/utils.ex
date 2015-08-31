defmodule Trs.Couchdb.Utils do
  def get_doc(url) do
    %HTTPoison.Response{body: body, status_code: status_code} = Trs.Couchdb.Http.get!(url, [])
    {body, status_code}
  end

  def get_all_docs(url) do
    {body, status_code} = get_doc(url <> "/_all_docs?include_docs=true")
    if status_code in 200..399 do
      docs = Enum.reduce(Poison.decode!(body)["rows"], Map.new, fn(item, acc) ->
        if item["id"] != "project" do
          Map.put(acc, item["doc"]["_id"], Dict.drop(item["doc"], ["_id", "_rev"]))
        else
          acc
        end
      end)
      {docs, status_code}
    else
      {%{}, status_code}
    end
  end

  def create_doc(url, params) do
    %HTTPoison.Response{body: body, status_code: status_code} =
      Trs.Couchdb.Http.put!(url, Poison.encode!(params))
    {body, status_code}
  end

  def update_doc(url, params) do
    {body, _} = get_doc(url)
    %HTTPoison.Response{body: body, status_code: status_code} =
      Trs.Couchdb.Http.put!(url <> "?rev=#{Poison.decode!(body)["_rev"]}", Poison.encode!(params))
    {body, status_code}
  end

  def update_doc(url, key, value) do
    {body, _} = get_doc(url)
    doc = Poison.decode!(body)
    doc = update_couch_doc(key, value, Dict.drop(doc, ["_id"]))
    %HTTPoison.Response{body: body, status_code: status_code} =
      Trs.Couchdb.Http.put!(url, Poison.encode!(doc))
    {body, status_code}
  end

  def delete_doc(url) do
    {body, _} = get_doc(url)
    rev = Poison.decode!(body)["_rev"]
    %HTTPoison.Response{body: body, status_code: status_code} =
      Trs.Couchdb.Http.delete!("#{url}?rev=#{rev}", [])
    {body, status_code}
  end

  defp update_couch_doc(key, value, doc) do
    deep_update(String.split(key, "."), value, doc)
  end

  defp deep_update([h|[]], value, doc) do
    Dict.put(doc, h, value)
  end

  defp deep_update([h|t], value, doc) do
    case Dict.fetch(doc, h) do
      {:ok, dict} ->
        Dict.put(doc, h, deep_update(t, value, dict))
      :error ->
        Dict.put(doc, h, deep_update(t, value, HashDict.new))
    end
  end

  defp deep_update([], _value, doc) do
    doc
  end
end
