# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :messaging,
  ecto_repos: [Messaging.Repo]

# Configures the endpoint
config :messaging, MessagingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oIgnhmkLetK05Bufb+MMzF2+nrWngFEFrY3FGJfVOftRWy+oG/uhnAI1QpuLpUGD",
  render_errors: [view: MessagingWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Messaging.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure your database
config :messaging, Messaging.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  ssl: (System.get_env("DATABASE_USE_SSL") || "false") |> String.to_atom,
  pool_size: 5

config :absinthe,
  schema: Messaging.Schema

config :messaging, Messaging.Guardian,
  issuer: "messaging",
  secret_key: "S/GpKKwdu2lH6tgSxkvh5EkAc0RorcPOPHkeJIBDEZrjTcJZha1tvXnzzX3kCB2O"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
