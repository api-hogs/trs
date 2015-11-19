defmodule Trs.Mixfile do
  use Mix.Project

  def project do
    [app: :trs,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Trs, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger,
       :httpoison,  :phoenix_ecto, :postgrex, :phoenix_token_auth,
       :ja_serializer, :httpoison, :cors_plug ]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 1.0.2"},
     {:phoenix_ecto, "~> 1.2.0"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_token_auth, git: "git://github.com/romankuznietsov/phoenix_token_auth.git"},
     {:ja_serializer, git: "git://github.com/AgilionApps/ja_serializer.git"},
     {:phoenix_html, "~> 2.1"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:exrm, "~> 0.19.6"},
     {:cowboy, "~> 1.0"},
     {:httpoison, "~> 0.7.2"},
     {:bureaucrat, "~> 0.0.4", only: :test},
     {:mock, "~> 0.1.0", only: :test},
     {:cors_plug, "~> 0.1.3"}
   ]
  end
end
