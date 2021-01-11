defmodule Geott.Repo.Migrations.AddLocations do
  use Ecto.Migration

  def up do
    execute("SELECT AddGeometryColumn('tasks', 'pickup_point', 4326, 'POINT', 2)")
    execute("SELECT AddGeometryColumn('tasks', 'delivery_point', 4326, 'POINT', 2)")
    execute("CREATE INDEX tasks_pickup_index on tasks USING gist (pickup_point)")
  end

  def down do
    execute("ALTER TABLE tasks DROP COLUMN IF EXISTS pickup_point")
    execute("ALTER TABLE tasks DROP COLUMN IF EXISTS delivery_point")
  end
end
