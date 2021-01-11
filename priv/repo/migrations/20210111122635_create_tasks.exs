defmodule Geott.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    StatusEnum.create_type

    create table(:tasks, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :status, StatusEnum.type(), default: "new"
      add :driver_id, references(:users, type: :uuid, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:driver_id])
  end
end
