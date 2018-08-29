defmodule AfyWeb.Router do
  use AfyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AfyWeb do
    pipe_through :api
  end
end
