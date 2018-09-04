defmodule AfyWeb.V1.GoogleCloudControllerTest do
  use AfyWeb.ConnCase, async: true

  alias Afy.Accounts
  alias Afy.Accounts.User

  def create_user(user) do
    {:ok, user = %User{}} = Accounts.create_user(user)
    user
  end

  setup %{conn: conn} do
    user = create_user(%{email: "test@afy.com", password: "password", password_confirmation: "password"})
    {:ok, token, _claims} = Afy.Accounts.Guardian.encode_and_sign(user)
    conn = conn
      |> put_req_header("accept", "application/json")
      |> put_req_header("authorization", "Bearer #{token}")
    {:ok, conn: conn}
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

    test "with no Authorization", %{conn: conn} do
      valid_params = %{url: "http://www.artyfactory.com/art_appreciation/animals_in_art/pablo_picasso/picasso_bulls.jpg"}
      conn = conn
        |> delete_req_header("authorization")
        |> post(google_cloud_path(conn, :vision), image: valid_params)
      json_response(conn, 401)
    end
  end
end
