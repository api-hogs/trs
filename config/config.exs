# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :trs, Trs.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "K6QaaTveC7r6nx233RYOfNhvjvOgRDMndM9mXdY0Kmscmf3k8/JScgl1YiVShJ9H",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Trs.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]


config :joken,
  json_module: PhoenixTokenAuth.PoisonHelper,
  algorithm: :HS256 # Optional. defaults to :HS256

config :plug, :mimes, %{
  "application/vnd.api+json" => ["json-api"]
}
config :phoenix, :format_encoders, "json-api": Poison

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
