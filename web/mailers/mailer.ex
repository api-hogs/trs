defmodule Trs.Mailer do
  @behaviour Trs.MailingBehaviour

  def welcome_subject(user, _conn), do: "Hello #{user.email}"
  def welcome_body(_user, _token, _conn) do
    "Follow link"
  end

  def password_reset_subject(user, _conn), do: "Hello #{user.email}"

  def password_reset_body(_user, _reset_token, _conn) do
    "Follow link"
  end

  def new_email_address_subject(_user, _conn), do: "Please confirm your email address"

  def new_email_address_body(_user, _confirmation_token, _conn) do
    "Follow link"
  end

end
