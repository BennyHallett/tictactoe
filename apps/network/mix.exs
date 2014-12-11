defmodule Network.Mixfile do
  use Mix.Project

  def project do
    [app: :network,
     version: "0.0.1",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.0",
     deps: deps]
  end

  def application do
    [applications: [:logger],
     mod: {Network, []}]
  end

  defp deps do
    []
  end
end
