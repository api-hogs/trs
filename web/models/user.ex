defmodule Trs.User do
  use Ecto.Model

  schema "users" do
    field :email,                       :string
    field :hashed_password,             :string
    field :hashed_confirmation_token,   :string
    field :confirmed_at,                 Ecto.DateTime
    field :hashed_password_reset_token, :string
    field :unconfirmed_email,           :string
    field :authentication_tokens,       {:array, :string}, default: []
    has_many :projects, Trs.Project,    foreign_key: :user_id

    timestamps
  end

  @required_fields ~w()
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  # def phoenix_token_auth_validator(changeset = %{params: %{"password" => password}}) when password != nil and password != "" do
  #   if String.length(password) < 6 do
  #     changeset = Ecto.Changeset.add_error(changeset, :password, :too_short)
  #   end
  #   changeset
  # end
  def phoenix_token_auth_validator(changeset), do: changeset

end
