defmodule Trs.AuthTest do
  use Trs.ConnCase
  import Mock

  test "401 when get acount not authenticated" do
    response = get conn(), "/api/v1/account"
    assert response.status == 401
  end

  test "register new user" do
    with_mock Mailgun.Client, [send_email: fn _, _ -> {:ok, "response"} end] do
      response = conn()
                  |> post("/api/v1/users", %{data: %{attributes: %{email: @email, password: @password}}})
                  |> doc
      assert json_api_response(response, 200)
    end
  end

  test "can login" do
    %User{email: @email, hashed_password: @hashed_password, confirmed_at: Ecto.DateTime.utc}
    |> Repo.insert!

    response = conn() |> post "/api/v1/sessions", %{email: @email, password: @password}
    assert json_response(response, 200)
  end

  test "can logout" do
    response = conn() |> signin_user |> delete "/api/v1/sessions"
    assert json_response(response, 200)
  end
end
