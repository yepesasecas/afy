defmodule AfyWeb.V1.JayUserController do
  use AfyWeb, :controller

  alias Afy.Jay
  alias Afy.Jay.User

  action_fallback AfyWeb.FallbackController

  def index(conn, _params) do
    users = Jay.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Jay.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", jay_user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Jay.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Jay.get_user!(id)

    with {:ok, %User{} = user} <- Jay.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Jay.get_user!(id)
    with {:ok, %User{}} <- Jay.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
