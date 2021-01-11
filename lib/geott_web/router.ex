defmodule GeottWeb.Router do
  use GeottWeb, :router
  use Pow.Phoenix.Router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/api", GeottWeb do
    pipe_through :api
  end
end
