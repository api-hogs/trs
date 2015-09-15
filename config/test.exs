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

config :phoenix_token_auth,
  user_model: Trs.User,
  repo: Trs.Repo,
  crypto_provider: Comeonin.Bcrypt,
  token_validity_in_minutes: 7 * 24 * 60,
  email_sender: "info@hundehjem.com",
  emailing_module: Trs.Mailer,
  mailgun_mode: :test,
  mailgun_domain: "hundehjem.com",
  mailgun_key: "secret",
  user_model_validator: {Trs.User, :phoenix_token_auth_validator}

config :joken,
  secret_key: "very secret test key"
