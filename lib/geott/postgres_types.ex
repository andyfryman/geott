import EctoEnum

defenum StatusEnum, :status, [:new, :assigned, :done]

Postgrex.Types.define(
  Geott.PostgresTypes,
  [Geo.PostGIS.Extension] ++ Ecto.Adapters.Postgres.extensions(),
  json: Jason
)
