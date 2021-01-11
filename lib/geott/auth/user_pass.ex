defmodule Geott.Auth.UserPass do
  defstruct [:email, :password]

  @type t() :: %__MODULE__{}
end
