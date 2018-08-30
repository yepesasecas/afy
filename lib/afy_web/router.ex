defmodule AfyWeb.Router do
  use AfyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Afy.Guardian.AuthPipeline
  end

  scope "/api/v1", AfyWeb do
    pipe_through :api

    post "/sign_up", UserController, :create
    post "/sign_in", UserController, :sign_in
  end

  scope "/api/v1", AfyWeb do
    pipe_through [:api, :jwt_authenticated]

    get "/me", UserController, :show
  end
end
