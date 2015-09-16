defmodule Trs.Api.V1.UsersController do
  use Trs.Web, :controller
  alias PhoenixTokenAuth.Registrator
  alias PhoenixTokenAuth.Confirmator
  alias PhoenixTokenAuth.Authenticator
  alias PhoenixTokenAuth.Mailer
  alias PhoenixTokenAuth.Util
  alias PhoenixTokenAuth.UserHelper
  alias PhoenixTokenAuth.AccountUpdater
  alias Trs.Repo
  alias Trs.User

  plug :scrub_params, "data" when action in [:update]

  @doc """
  Sign up as a new user.
  Params should be:
      {user: {email: "user@example.com", password: "secret"}}
  If successfull, sends a welcome email.
  Responds with status 200 and body {user: {id: id, email: email, token: token}} if successfull.
  Responds with status 422 and body {errors: {field: "message"}} otherwise.
  """
  def create(conn, params = %{"data" => %{"attributes" => %{"email" => email}}}) when email != "" and email != nil do
    {confirmation_token, changeset} = Registrator.changeset(params["data"]["attributes"])
    |> Confirmator.confirmation_needed_changeset

    if changeset.valid? do
      user = Util.repo.insert!(changeset)
      Task.async(fn -> Mailer.send_welcome_email(user, confirmation_token, conn) end)
      token = Authenticator.generate_token_for(user)
      user = Map.put_new(user, :token, token)
      render(conn, "show.json-api", user: user)
    else
      Util.send_error(conn, Enum.into(changeset.errors, %{}))
    end
  end


  @doc """
  Confirm either a new user or an existing user's new email address.
  Parameter "id" should be the user's id.
  Parameter "confirmation" should be the user's confirmation token.
  If the confirmation matches, the user will be confirmed and signed in.
  Responds with status 200 and body {token: token} if successfull. Use this token in subsequent requests as authentication.
  Responds with status 422 and body {errors: {field: "message"}} otherwise.
  """
  def confirm(conn, params = %{"id" => user_id, "confirmation_token" => _}) do
    user = Util.repo.get! UserHelper.model, user_id
    changeset = Confirmator.confirmation_changeset user, params
    if changeset.valid? do
      Util.repo.update!(changeset)
      token = Authenticator.generate_token_for(user)
      json conn, %{token: token, user_id: user_id}
    else
      Util.send_error(conn, Enum.into(changeset.errors, %{}))
    end
  end

  @doc """
  Resend confirmation link.
  Parameter "email" should be the user's email.
  If an account is not confirmed yet then the confirmation will be sent.
  Responds with status 200 and body {} if successfull.
  Responds with status 422 and body {errors: {field: "message"}} otherwise.
  """

  def resend(conn, params = %{"email" => email}) do
    user = Repo.get_by(User, email: email)
    changeset = User.changeset(user, params)
    if user do
      if is_nil(user.hashed_confirmation_token) do
        Util.send_error(conn, %{base: "Account was confirmed already"}, 422)
      else
        {confirmation_token, changeset} = Confirmator.confirmation_needed_changeset(changeset)
        Task.async(fn -> Mailer.send_welcome_email(user, confirmation_token, conn) end)
        Util.repo.update!(changeset)
        json conn, 200
      end
    else
      Util.send_error(conn, %{base: "Account is not existed"}, 422)
    end
  end

  def resend(conn, %{}) do
    Util.send_error(conn, %{base: "Email can't be blank"}, 422)
  end

end
