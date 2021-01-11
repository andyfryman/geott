defmodule Geott.Users do
  alias Geott.{Repo, Users.User}

  @type t :: %User{}

  @spec create_manager(map()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def create_manager(params) do
    %User{}
    |> User.changeset(params)
    |> User.changeset_role(%{role: "manager"})
    |> Repo.insert()
  end

  @spec create_driver(map()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def create_driver(params) do
    %User{}
    |> User.changeset(params)
    |> User.changeset_role(%{role: "driver"})
    |> Repo.insert()
  end

end
