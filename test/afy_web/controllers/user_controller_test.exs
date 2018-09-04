defmodule AfyWeb.UserControllerTest do
  use AfyWeb.ConnCase

  alias Afy.Accounts
  alias Afy.Accounts.User

  def create_user(user) do
    {:ok, user = %User{}} = Accounts.create_user(user)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create user" do
    test "with valid parameters", %{conn: conn} do
      valid_params = %{
        email: "test@afy.com",
        password: "password",
        password_confirmation: "password"
      }

      conn = post(conn, user_path(conn, :create), user: valid_params)
      body = json_response(conn, 201)
      assert %{"jwt" => _jwt_token} = body
    end

    test "with different password_confirmation", %{conn: conn} do
      invalid_params = %{
        email: "test@afy.com",
        password: "password",
        password_confirmation: "passw000rd"
      }

      conn = post(conn, user_path(conn, :create), user: invalid_params)
      body = json_response(conn, 422)
      assert %{"errors" => _errors} = body
    end

    test "with no parameters", %{conn: conn} do
      invalid_params = %{}

      conn = post(conn, user_path(conn, :create), user: invalid_params)
      body = json_response(conn, 422)
      assert %{"errors" => _errors} = body
    end
  end

  describe "sign in user" do
    test "with valid params", %{conn: conn} do
      user = create_user(%{email: "test@afy.com", password: "password", password_confirmation: "password"})

      conn = post(conn, user_path(conn, :sign_in), user: %{email: user.email, password: user.password})
      body = json_response(conn, 200)
      assert %{"jwt" => _jwt_token} = body
    end

    test "non existing user",  %{conn: conn} do
      invalid_params = %{email: "invalid@email.com", password: "invaalid"}

      conn = post(conn, user_path(conn, :sign_in), user: invalid_params)
      body = json_response(conn, 401)
      assert %{"errors" => _errors} = body
    end

    test "with invalid password", %{conn: conn} do
      user = create_user(%{email: "test@afy.com", password: "password", password_confirmation: "password"})

      conn = post(conn, user_path(conn, :sign_in), user: %{email: user.email, password: "invalid_password"})
      body = json_response(conn, 401)
      assert %{"errors" => _errors} = body
    end
  end

  describe "show user" do
    test "with valid jwt token", %{conn: conn} do
      user = create_user(%{email: "test@afy.com", password: "password", password_confirmation: "password"})
      {:ok, token, _claims} = Afy.Accounts.Guardian.encode_and_sign(user)

      body = conn
        |> put_req_header("authorization", "Bearer #{token}")
        |> get(user_path(conn, :show), user: %{email: user.email, password: user.password})
        |> json_response(200)
      assert %{"email" => _} = body
    end

    test "with invalid jwt token", %{conn: conn} do
      user = create_user(%{email: "test@afy.com", password: "password", password_confirmation: "password"})
      {:ok, token, _claims} = Afy.Accounts.Guardian.encode_and_sign(user)
      conn
      |> put_req_header("authorization", "Bearer #{token}invalid")
      |> get(user_path(conn, :show), user: %{email: user.email, password: user.password})
      |> json_response(401)
    end

    test "with no jwt header", %{conn: conn} do
      user = create_user(%{email: "test@afy.com", password: "password", password_confirmation: "password"})
      conn
      |> get(user_path(conn, :show), user: %{email: user.email, password: user.password})
      |> json_response(401)
    end
  end
end
