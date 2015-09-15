use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :trs, Trs.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  cache_static_lookup: false,
  check_origin: false,
  watchers: []

# Watch static and templates for browser reloading.
config :trs, Trs.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development.
# Do not configure such in production as keeping
# and calculating stacktraces is usually expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :trs, Trs.Repo,
  adapter: Ecto.Adapters.Postgres,
  host: "localhost",
  database: "trs_dev",
  size: 10 # The amount of database connections in the pool

config :phoenix_token_auth,
  user_model: Trs.User,
  repo: Trs.Repo,
  crypto_provider: Comeonin.Bcrypt,
  token_validity_in_minutes: 7 * 24 * 60,
  email_sender: "info@sandboxd97f3d3709954463ac6a8db4316e7aac.mailgun.org",
  emailing_module: Trs.Mailer,
  mailgun_domain: "https://api.mailgun.net/v3/sandboxd97f3d3709954463ac6a8db4316e7aac.mailgun.org",
  mailgun_key: "key-1fdd3873937ad32f5bcb92a711ac8391",
  user_model_validator: {Trs.User, :phoenix_token_auth_validator}

config :joken,
  secret_key: "very secret test key"
