# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :skul,
  ecto_repos: [Skul.Repo]

# Configures the endpoint
config :skul, SkulWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "AAC1oNMb4iVigbYqs5UWv2lo2m0VzolsL75BW7qLWLFpT7fYL13dv8yXwUU0FBD2",
  render_errors: [view: SkulWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Skul.PubSub,
  live_view: [signing_salt: "OWOpt9+J"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
