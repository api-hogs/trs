defmodule Trs.Couchdb.Responder do
   defmacro __using__([]) do
     quote do
       def exclude_params, do: ["_rev", "_id", "ok", "id", "rev"]

       def respond_couchdb_document(body, status_code, conn) do
         body = Poison.decode!(body)
         if status_code in 200..299 do
           body = Dict.drop(body, exclude_params)
           conn
           |> put_status(status_code)
           |> json body
         else
           conn
           |> put_status(status_code)
           |> json %{}
         end
       end
     end
   end
end
