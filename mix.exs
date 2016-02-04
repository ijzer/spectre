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
    [applications: [:logger],
     mod: {Spectre, []}]
  end

  defp deps do
    [
			{:credo, "~> 0.2", only: [:dev, :test]},
			{:inch_ex, only: [:dev, :test]},
			{:dialyxir, "~> 0.3", only: [:dev]},
			{:excoveralls, "~> 0.4", only: :test},
      {:excheck, "~> 0.3", only: :test},
      {:triq, github: "krestenkrab/triq", only: :test},
			{:amrita, "~>0.4", github: "josephwilk/amrita", only: :test}
		]
  end
end
