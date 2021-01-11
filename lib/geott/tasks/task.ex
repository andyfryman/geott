defmodule Geott.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Geott.Users.User
  alias Geo.PostGIS.Geometry

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tasks" do
    field :status, StatusEnum, read_after_writes: true
    belongs_to :driver, User
    field :pickup_point, Geometry
    field :delivery_point, Geometry
    field :pickup, {:array, :float}, virtual: true
    field :delivery, {:array, :float}, virtual: true

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:status])
    |> validate_required([:status])
  end

  def changeset_create(task, attrs) do
    task
    |> cast(attrs, [:pickup, :delivery])
    |> validate_required([:pickup, :delivery])
    |> validate_length(:pickup, is: 2)
    |> validate_length(:delivery, is: 2)
    |> put_pickup_point()
    |> put_delivery_point()
  end

  defp put_pickup_point(cs) do
    case cs do
      %{valid?: true} ->
        loc = get_field(cs, :pickup)
        cs
        |> put_change(:pickup_point, %Geo.Point{coordinates: {Enum.at(loc, 0), Enum.at(loc, 1)}, srid: 4326})
      _ ->
        cs
    end
  end

  defp put_delivery_point(cs) do
    case cs do
      %{valid?: true} ->
        loc = get_field(cs, :delivery)
        cs
        |> put_change(:delivery_point, %Geo.Point{coordinates: {Enum.at(loc, 0), Enum.at(loc, 1)}, srid: 4326})
      _ ->
        cs
    end
  end
end
