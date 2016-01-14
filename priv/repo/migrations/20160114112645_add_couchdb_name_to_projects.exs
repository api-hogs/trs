defmodule Trs.Repo.Migrations.AddCouchdbNameToProjects do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add :couchdb_name, :text
    end
  end
end
