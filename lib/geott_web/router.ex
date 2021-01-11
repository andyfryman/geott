defmodule GeottWeb.Router do
  use GeottWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GeottWeb do
    pipe_through :api
  end
end
