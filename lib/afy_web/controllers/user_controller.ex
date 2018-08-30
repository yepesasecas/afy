defmodule AfyWeb.UserController do
  use AfyWeb, :controller

  alias Afy.Accounts
  alias Afy.Accounts.User
  alias Afy.Guardian

  action_fallback AfyWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("jwt.json",jwt: token)
    end
  end

  def sign_in(conn, %{"user" => %{"email" => email, "password" => password}}) do
    with {:ok, token, _claims} <- Accounts.token_sign_in(email, password) do
      conn
      |> render("jwt.json", jwt: token)
    end
  end

  def show(conn, _params) do
    with user <- Guardian.Plug.current_resource(conn) do
      conn
      |> render("user.json", user: user)
    end
  end
end
