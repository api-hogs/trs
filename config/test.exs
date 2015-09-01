use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :trs, Trs.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Set a higher stacktrace during test
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :trs, Trs.Repo,
  adapter: Ecto.Adapters.Postgres,
  host: "localhost",
  database: "trs_test",
  pool: Ecto.Adapters.SQL.Sandbox, # Use a sandbox for transactional testing
  size: 1

