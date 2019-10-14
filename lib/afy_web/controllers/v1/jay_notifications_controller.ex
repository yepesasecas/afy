defmodule AfyWeb.V1.JayNotificationsController do
  use AfyWeb, :controller

  alias Afy.Jay
  alias Afy.Jay.User
  alias Afy.Jay.Notification

  action_fallback AfyWeb.FallbackController

  def create(conn, %{"notification" => %{"username" => username, "aps" => aps}}) do
    with %User{} = user <- Jay.get_user_by_username!(username),
         response <- Notification.push(user, aps) do
      conn
      |> put_status(:created)
      |> json(response)
    end
  end
end
