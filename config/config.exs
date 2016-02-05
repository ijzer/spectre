use Mix.Config

config :maru, Spectre.API.Spectre,
  versioning: [
	  using: :path
	],
	http: [port: 49862]
	
