defmodule Trs.Api.V1.LanguagesControllerTest do
  use Trs.ConnCase

  @project "trs-db"

  setup do
    conn = conn()
            |> put_req_header("accept", "application/json")
            # |> signin_user

    {:ok, conn: conn}
  end

end
