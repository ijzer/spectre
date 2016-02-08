defmodule Spectre.Mixfile do
  use Mix.Project

  def project do
    [app: :spectre,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
		 test_coverage: [tool: ExCoveralls],
		 preferred_cli_env: ["coveralls": :test,
												 "coveralls.detail": :test,
												 "coveralls.post": :test]
    ]
  end

  def application do
    [applications: [:logger, :cowboy, :plug],
     mod: {Spectre, []}]
  end

  defp deps do
    [
			{:cowboy, "~> 1.0.0"},
			{:plug, "~> 1.0"},
			{:poison, "~> 2.0"},
			{:xml_builder, "~> 0.0.6"},
			{:sweet_xml, "~> 0.5.0", only: :test},
			{:credo, "~> 0.2", only: :dev},
			{:inch_ex, "~> 0.5.1", only: :dev},
			{:dialyxir, "~> 0.3", only: :dev},
      {:excheck, "~> 0.3", only: :test},
      {:triq, github: "krestenkrab/triq", only: :test},
		]
  end
end
