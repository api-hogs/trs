defmodule Trs.Mailer do
  @behaviour PhoenixTokenAuth.MailingBehaviour

  def welcome_subject(user, _conn), do: "Hello #{user.email}"
  def welcome_body(user, token, _conn) do
    """
    Welcome to our service!
    """
  end

  def password_reset_subject(user, _conn), do: "Hello #{user.email}"
  def password_reset_body(user, reset_token, _conn) do
    """
    Please follow the link below:
    http://localhost:4200/resend/?token=#{reset_token}
    """
  end

  def new_email_address_subject(_user, _conn), do: "Please confirm your email address"
  def new_email_address_body(user, confirmation_token, _conn) do
    """
    Please follow the link below:
    http://localhost:4200/confirmation/?user=#{user.email}&token=#{confirmation_token}
    """
  end

end
