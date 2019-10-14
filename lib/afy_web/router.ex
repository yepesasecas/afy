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

    post "/sign_up", V1.UserController, :create
    post "/sign_in", V1.UserController, :sign_in
  end

  scope "/api/v1", AfyWeb do
    pipe_through [:api, :jwt_authenticated]

    get "/me", V1.UserController, :show
    post "/google_cloud/vision", V1.GoogleCloudController, :vision
    post "/classify", V1.ClassifyController, :classify
  end

  scope "/api/v1/jay", AfyWeb do
    pipe_through :api
    resources "/users", V1.JayUserController, except: [:new, :edit]
    resources "/notifications", V1.JayNotificationsController, only: [:create]
  end
end
