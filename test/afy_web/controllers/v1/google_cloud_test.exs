defmodule AfyWeb.V1.GoogleCloudControllerTest do
  use AfyWeb.ConnCase, async: true

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "object in image" do
    test "with valid url params", %{conn: conn} do
      valid_params = %{url: "http://www.artyfactory.com/art_appreciation/animals_in_art/pablo_picasso/picasso_bulls.jpg"}
      conn = post(conn, google_cloud_path(conn, :vision), image: valid_params)
      body = json_response(conn, 200)
      assert %{"responses" => [%{"labelAnnotations" => _labels}]} = body
    end

    test "with valid local image params", %{conn: conn} do
      valid_params = %{source: Afy.GoogleCloud.Vision.local_image_base_64("./priv/assets/demo-image.jpg")}
      conn = post(conn, google_cloud_path(conn, :vision), image: valid_params)
      body = json_response(conn, 200)
      assert %{"responses" => [%{"labelAnnotations" => _labels}]} = body
    end

    test "with missing or misspelled params", %{conn: conn} do
      valid_params = %{misspelled_url: "http://www.artyfactory.com/art_appreciation/animals_in_art/pablo_picasso/picasso_bulls.jpg"}
      conn = post(conn, google_cloud_path(conn, :vision), image: valid_params)
      _body = json_response(conn, 422)
    end
  end
end
