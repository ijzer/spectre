defmodule Spectre do
  use Application

	@port Application.get_env(:spectre, :port, 4000)

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

		Plug.Adapters.Cowboy.http(Spectre.API, [], port: @port, compress: true)

    children = []
			
    opts = [strategy: :one_for_one, name: Spectre.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
