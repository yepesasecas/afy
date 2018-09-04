defmodule AfyWeb.V1.GoogleCloudController do
  use AfyWeb, :controller
  alias Afy.GoogleCloud.Vision


  action_fallback AfyWeb.FallbackController

  def vision(conn, %{"image" => %{"url" => url}}) do
    with vision_res <- Vision.object_in_image_url(url) do
      conn
      |> put_status(:ok)
      |> render("vision.json", responses: vision_res)
    end
  end
  def vision(conn, %{"image" => %{"source" => image_source}}) do
    with vision_res <- Vision.object_in_image(image_source) do
      conn
      |> put_status(:ok)
      |> render("vision.json", responses: vision_res)
    end
  end
end
