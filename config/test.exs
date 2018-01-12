use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :messaging, MessagingWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :messaging, Messaging.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_TEST_URL"),
  ssl: false,
  pool: Ecto.Adapters.SQL.Sandbox,
  # Prevent timeout during debug sessions with IEx
  ownership_timeout: 999_999,
  timeout: 999_999
