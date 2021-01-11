defmodule Geott.Repo.Migrations.AddUserRole do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :role, :string, null: false, default: "driver"
    end
  end
end
