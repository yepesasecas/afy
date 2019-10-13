# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :afy,
  ecto_repos: [Afy.Repo]

# Configures the endpoint
config :afy, AfyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5PEQjQWfsK2cqzmBw3+oA6Yt27G+1Xn+lP9VA2cYS/oiHcScY0cJB2rwOi8tkLaC",
  render_errors: [view: AfyWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Afy.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Configures Guardian
config :afy, Afy.Accounts.Guardian,
  issuer: "afy",
  secret_key: "FMj6DFVHYLK39Me1EGC32YPpt3b8inLcCNU0hQ4vF5TDStlodbcsqxdL8k+12bvN"

# Google Vision API Key
config :afy, google_cloud_vision_api_key: System.get_env("GOOGLE_CLOUD_VISION_API_KEY")

# Pigeon https://github.com/codedge-llc/pigeon
#> n = Pigeon.APNS.Notification.new("hello!", "fe0e27c247bb1d5b2bc964617336d7c345e224a440d997eef4032680283eec0f", "topic optional")
#> Pigeon.APNS.push(n)
config :pigeon, :apns,
  apns_default: %{
    key: "./certs/ios/AuthKey_VT63UC8JQ8.p8",
    key_identifier: "VT63UC8JQ8",
    team_id: "9BZ568JFC6",
    mode: :dev
  }

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
