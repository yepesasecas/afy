defmodule Afy.GoogleCloud.Vision do
  require Logger

  def object_in_image(img), do: object_in_image_do(%{content: img})

  def object_in_image_url(img), do: object_in_image_do(%{source: %{imageUri: img}})

  def local_image_base_64(path) do
    path
    |> File.read!()
    |> Base.encode64()
  end

  # private

  defp object_in_image_do(image_section) do
    image_section
    |> body_request()
    |> http_request()
  end

  defp body_request(image_section) do
    Poison.encode!(%{
      requests: [%{
        features: [%{
          type: "LABEL_DETECTION"
        }],
        image: image_section
      }]
    })
  end

  defp http_request(body) do
    url = URI.parse("https://vision.googleapis.com/v1/images:annotate")
      |> set_api_key()
      |> URI.to_string()

    case HTTPoison.post(url, body) do
      {:ok, %HTTPoison.Response{body: body}} -> Poison.decode!(body)
      {:error, error} ->
        Logger.info(error)
        error
    end
  end

  defp set_api_key(url) do
    url
    |> Map.put(:query, "key=#{Application.get_env(:afy, :google_cloud_vision_api)}")
  end
end
