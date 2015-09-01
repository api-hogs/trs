defmodule Trs.Couchdb.Responder do
   defmacro __using__([]) do
     quote do
       def respond_couchdb_document(body, status_code, conn) do
         if status_code in 200..299 do
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
