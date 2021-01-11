defmodule GeottWeb.Router do
  use GeottWeb, :router
  use Pow.Phoenix.Router

  pipeline :api do
    plug :accepts, ["json"]
    plug Geott.Auth.AuthFlow, otp_app: :geott
  end

  pipeline :api_protected do
    plug Pow.Plug.RequireAuthenticated, error_handler: GeottWeb.ApiAuthErrorHandler
  end

  pipeline :manager do
    plug GeottWeb.EnsureRolePlug, :manager
  end

  pipeline :driver do
    plug GeottWeb.EnsureRolePlug, :driver
  end

  scope "/api/auth", GeottWeb.Controllers do
    pipe_through :api

    post "/login", AuthController, :login
  end

  scope "/api", GeottWeb do
    pipe_through [:api, :api_protected]

    get "/tasks/:id", TaskController, :show
  end

  scope "/api", GeottWeb do
    pipe_through [:api, :api_protected, :driver]

    post "/tasks/search", TaskController, :search
    put "/tasks/:id", TaskController, :update
  end

  scope "/api", GeottWeb do
    pipe_through [:api, :api_protected, :manager]

    post "/tasks", TaskController, :create
  end
end
