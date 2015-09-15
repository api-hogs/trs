defmodule Trs.Repo.Migrations.CreateUser do
  use Ecto.Migration
  @disable_ddl_transaction true

  def change do
    create table(:users) do
      add :email, :text
      add :hashed_password, :text
      add :hashed_confirmation_token, :text
      add :confirmed_at, :datetime
      add :hashed_password_reset_token, :text
      add :unconfirmed_email, :text
      add :authentication_tokens, {:array, :string}
      timestamps
    end

    create index(:users, [:email], concurrently: true)
    create index(:users, [:hashed_password_reset_token], concurrently: true)
    create index(:users, [:hashed_confirmation_token], concurrently: true)
  end
end
