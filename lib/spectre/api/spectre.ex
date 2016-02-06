defmodule Spectre.API.Spectre do
	use Plug.Router

	plug Plug.Logger
	plug :match
	plug :dispatch

	forward "/v1", to: Spectre.API.Spectre.V1
	
	match _ do
		send_resp(conn, 404, Atom.to_string(__MODULE__))
	end
end
