defmodule GeottWeb.Controllers.AuthController do
  use GeottWeb, :controller

  alias Plug.Conn
  alias Geott.Auth.UserPass

  @spec login(Conn.t(), UserPass.t()) :: Conn.t()
  def login(conn, user_pass) do
    with {:ok, conn} <- conn |> Pow.Plug.authenticate_user(user_pass) do
      json(conn, %{token: conn.private[:api_access_token]})
    else
      {:error, conn} ->
        conn
        |> put_status(401)
        |> json(%{error: %{status: 401, message: "Invalid email or password"}})
    end
  end

end
