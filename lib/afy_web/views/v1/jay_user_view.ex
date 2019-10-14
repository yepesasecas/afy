defmodule AfyWeb.V1.JayUserView do
  use AfyWeb, :view
  alias AfyWeb.V1.JayUserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, JayUserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, JayUserView, "user.json")}
  end

  def render("user.json", %{jay_user: user}) do
    %{id: user.id,
      username: user.username,
      device_token: user.device_token}
  end
end
