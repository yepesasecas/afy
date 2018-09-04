defmodule Afy.GoogleCloud.VisionTest do
  use Afy.DataCase

  describe "object in image" do
    test "with local image" do
      img_base64 = Afy.GoogleCloud.Vision.local_image_base_64("./priv/assets/demo-image.jpg")
      assert %{"responses" => [%{"labelAnnotations" => _labels}]} = Afy.GoogleCloud.Vision.object_in_image(img_base64)
    end

    test "with http URL" do
      img_url = "http://www.artyfactory.com/art_appreciation/animals_in_art/pablo_picasso/picasso_bulls.jpg"
      assert %{"responses" => [%{"labelAnnotations" => _labels}]} = Afy.GoogleCloud.Vision.object_in_image_url(img_url)
    end
  end
end
