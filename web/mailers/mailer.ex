defmodule Trs.Mailer do
  alias Trs.Router.Helpers
  alias PhoenixTokenAuthReact.Endpoint

  @behaviour PhoenixTokenAuth.MailingBehaviour

  def welcome_subject(user, _conn), do: "Hello #{user.email}"
  def welcome_body(user, token, _conn) do
    """
    Please follow the link below:
    """
  end

  def password_reset_subject(user, _conn), do: "Hello #{user.email}"
  def password_reset_body(user, reset_token, _conn) do
    """
    Please follow the link below:
    #{Helpers.page_url(Endpoint, :index)}#/users/#{user.id}/reset_password/#{reset_token}
    """
  end

  def new_email_address_subject(_user, _conn), do: "Please confirm your email address"
  def new_email_address_body(user, confirmation_token, _conn) do
    """
    Please follow the link below:
    #{Helpers.page_url(Endpoint, :index)}#/users/#{user.id}/confirm/#{confirmation_token}
    """
  end

end
