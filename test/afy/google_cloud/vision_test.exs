defmodule Afy.GoogleCloud.VisionTest do
  use Afy.DataCase
  alias Afy.GoogleCloud.Vision.Image
  alias Afy.GoogleCloud.Vision

  describe "object in image" do
    test "with local image" do
      img_base64 = Vision.local_image_base_64("./priv/assets/demo-image.jpg")
      assert {:ok, img = %Image{}} = Vision.create_image(%{source: img_base64})
      assert %{"responses" => [%{"labelAnnotations" => _labels}]} = Vision.object_in_image(img)
    end

    test "with http URL" do
      img_url = "http://www.artyfactory.com/art_appreciation/animals_in_art/pablo_picasso/picasso_bulls.jpg"
      assert {:ok, img = %Image{}} = Vision.create_image(%{url: img_url})
      assert %{"responses" => [%{"labelAnnotations" => _labels}]} = Vision.object_in_image(img)
    end
  end
end
