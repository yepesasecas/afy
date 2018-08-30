defmodule Afy.AuthErrorHandler do
  import Plug.Conn
  use AfyWeb, :controller

  def auth_error(conn, {type, _reason}, _opts) do
    conn
    |> put_status(:unauthorized)
    |> render(AfyWeb.ErrorView, "401.json")
  end
end
