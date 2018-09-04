defmodule AfyWeb.V1.GoogleCloudView do
  use AfyWeb, :view

  def render("vision.json", %{responses: responses}) do
    responses
  end
end
