defmodule Afy.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :Afy, module: Afy.Accounts.Guardian, error_handler: Afy.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
