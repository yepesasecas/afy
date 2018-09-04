defmodule AfyWeb.V1.GoogleCloudController do
  use AfyWeb, :controller
  alias Afy.GoogleCloud.Vision


  action_fallback AfyWeb.FallbackController

  def vision(conn, %{"image" => image}) do
    with {:ok, img} <- Vision.create_image(image),
         vision_res <- Vision.object_in_image(img) do
      conn
      |> put_status(:ok)
      |> render("vision.json", responses: vision_res)
    end
  end
end
