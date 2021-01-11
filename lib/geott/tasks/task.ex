defmodule Geott.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Geott.Users.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tasks" do
    field :status, StatusEnum
    belongs_to :driver, User

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:status])
    |> validate_required([:status])
  end
end
