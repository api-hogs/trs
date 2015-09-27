defmodule Trs.Repo.Migrations.Project do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :title, :text
      add :user_id, references(:users)
      add :description, :text
      add :authentication_tokens, {:array, :string}
      timestamps
    end
  end
end
