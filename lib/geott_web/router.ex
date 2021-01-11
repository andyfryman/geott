defmodule GeottWeb.Router do
  use GeottWeb, :router
  use Pow.Phoenix.Router

  pipeline :api do
    plug :accepts, ["json"]
    plug Geott.Auth.AuthFlow, otp_app: :geott
  end

  pipeline :api_protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/api/auth", GeottWeb.Controllers do
    pipe_through :api

    post "/login", AuthController, :login
  end

  scope "/api", GeottWeb do
    pipe_through :api
  end
end
