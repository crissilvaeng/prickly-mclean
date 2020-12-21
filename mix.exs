defmodule PricklyMclean.MixProject do
  use Mix.Project

  def project do
    [
      app: :pm,
      version: "0.0.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    []
  end

  defp deps do
    []
  end
end
