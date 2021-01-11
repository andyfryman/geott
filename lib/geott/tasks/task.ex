defmodule Geott.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]
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

  def order_by_nearest(query, point) do
    {lng, lat} = point.coordinates

    from(r in query,
      order_by:
        fragment("? <-> ST_SetSRID(ST_MakePoint(?,?), ?)", r.pickup_point, ^lng, ^lat, 4326)
    )
  end

  def filter_available(query) do
    from(r in query,
      where:
        r.status < :assigned
    )
  end

  defp put_pickup_point(cs) do
    case cs do
      %{valid?: true} ->
        [lat, lng] = get_field(cs, :pickup)
        cs
        |> put_change(:pickup_point, %Geo.Point{coordinates: {lng, lat}, srid: 4326})
      _ ->
        cs
    end
  end

  defp put_delivery_point(cs) do
    case cs do
      %{valid?: true} ->
        [lat, lng] = get_field(cs, :delivery)
        cs
        |> put_change(:delivery_point, %Geo.Point{coordinates: {lng, lat}, srid: 4326})
      _ ->
        cs
    end
  end
end
