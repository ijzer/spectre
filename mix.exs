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
    [applications: [:logger, :maru],
     mod: {Spectre, []}]
  end

  defp deps do
    [
			{:poison, "~> 2.0"},
			{:plug, "~> 1.0"},
			{:maru, "~> 0.8"},
			{:sweet_xml, "~> 0.5", only: [:dev, :test]},
			{:credo, "~> 0.2", only: [:dev, :test]},
			{:inch_ex, "~> 0.5", only: [:dev, :test]},
			{:dialyxir, "~> 0.3", only: :dev},
			{:excoveralls, "~> 0.4", only: [:dev, :test]},
      {:excheck, "~> 0.3", only: [:dev, :test]},
      {:triq, github: "krestenkrab/triq", only: [:dev, :test]},
			{:amrita, "~>0.4", github: "josephwilk/amrita", only: [:dev, :test]}
		]
  end
end
