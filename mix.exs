defmodule RepoAgent.Mixfile do
  use Mix.Project

  def project do
    [app: :repo_agent,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
    #  elixirc_paths: elixirc_paths(Mix.env),
     test_paths: test_paths,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :ecto]]
  end

  def elixirc_paths(:test), do: ["lib", "web", "test/support"]
  def elixirc_paths(_), do: ["lib", "web"]

  defp test_paths do
    ["test", "integration_test"]
  end

  # defp elixirc_paths(:test), do: ["lib", "test/support", "integration_test"]
  # defp elixirc_paths(_),     do: ["lib"]

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:ecto, "~> 2.0.0-rc.0"},
     {:postgrex, "~> 0.11.1", optional: true}]
  end
end
