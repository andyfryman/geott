defmodule Geott.Tasks.SearchTask do
  use Ecto.Schema
  import Ecto.Changeset
  alias Geo.PostGIS.Geometry
  alias __MODULE__

  embedded_schema do
    field :location_point, Geometry
    field :location, {:array, :float}
  end

  def changeset(%SearchTask{} = search_task, attrs) do
    search_task
    |> cast(attrs, [:location])
    |> validate_required([:location])
    |> validate_length(:location, is: 2)
    |> put_location_point()
  end

  defp put_location_point(cs) do
    case cs do
      %{valid?: true} ->
        [lat, lng] = get_field(cs, :location)
        cs
        |> put_change(:location_point, %Geo.Point{coordinates: {lng, lat}, srid: 4326})
      _ ->
        cs
    end
  end
end
