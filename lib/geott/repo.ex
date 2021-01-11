defmodule Geott.Repo do
  use Ecto.Repo,
    otp_app: :geott,
    adapter: Ecto.Adapters.Postgres
end
