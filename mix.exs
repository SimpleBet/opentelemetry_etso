defmodule OpentelemetryEtso.MixProject do
  use Mix.Project

  def project do
    [
      app: :opentelemetry_etso,
      description: description(),
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      package: package(),
      source_url: "https://github.com/opentelemetry-beam/opentelemetry_etso"
    ]
  end

  defp description do
    "Trace Etso Ecto queries with OpenTelemetry."
  end

  defp package do
    [
      licenses: ["Apache-2"],
      links: %{"GitHub" => "https://github.com/opentelemetry-beam/opentelemetry_etso"}
    ]
  end

  def application do
    []
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:telemetry, "~> 0.4.0"},
      {:opentelemetry_api, "~> 0.3.1"},
      {:opentelemetry, "~> 0.4.0"},
      {:ex_doc, "~> 0.21.0", only: [:dev], runtime: false},
      {:ecto, ">= 3.0.0", only: [:test]}
    ]
  end
end
