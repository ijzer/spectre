defmodule Spectre.API.Subsonic do
	use Plug.Router

	plug Plug.Logger

	plug :match
	plug :dispatch

	match _ do
		send_resp(conn, 404, Atom.to_string(__MODULE__))
	end
end
