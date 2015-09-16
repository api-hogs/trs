defmodule Trs.Api.V1.UserSerializer do
  use JaSerializer
  alias Trs.User

  @private_attributes ~w(hashed_password hashed_confirmation_token confirmed_at
  hashed_password_reset_token unconfirmed_email authentication_tokens)

  serialize "users" do
    location "api/v1/users/:id"
    attributes([:token | User.__schema__(:fields)] -- @private_attributes)
  end
end
