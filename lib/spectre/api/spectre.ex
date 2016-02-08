defmodule Spectre.API.Spectre do
	use Plug.Router

	plug Plug.Logger
	plug :match
	plug :dispatch

	forward "/v1", to: Spectre.API.Spectre.V1
	
	match _ do
		send_resp(conn, 404, Atom.to_string(__MODULE__))
	end

	@server Application.get_env(:spectre, :name, "spectre")
	@version Mix.Project.config[:version]

	@spec response(atom, map) :: iodata
	@doc """
	Loads the given payload into a response and converts it to json.

  ## Examples

      iex> alias Spectre.API.Spectre, as: API
			iex> API.response(:ok)
			"{\"version\":\"0.0.1\",\"status\":\"ok\",\"server\":\"spectre\"}"
			iex> API.response(:error, %{error: %{code: 1, message: "no"}})
			"{\"version\":\"0.0.1\",\"status\":\"error\",\"server\":\"spectre\",\"error\":{\"message\":\"no\",\"code\":1}}"
	"""
	def response(status, payloads \\ %{}) do
		payloads
		|> Map.merge(%{status: status, server: @server, version: @version})
		|> Poison.encode!
	end
end
