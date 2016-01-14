defmodule Trs.Project do
  use Ecto.Model

  schema "projects" do
    field :title,                       :string
    field :description,                 :string
    field :couchdb_name,                :string
    field :user_id,                     :integer
    field :authentication_tokens,       {:array, :string}, default: []

    timestamps
  end

  @required_fields ~w(user_id title)
  @optional_fields ~w(description)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

end
