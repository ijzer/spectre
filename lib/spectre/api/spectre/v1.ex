defmodule Spectre.API.Spectre.V1 do
	use Plug.Router

	plug Plug.Logger
	plug :match
	plug :dispatch

	get "/status" do
		send_resp(conn, 501, Atom.to_string(__MODULE__))
	end

	match _ do
		send_resp(conn, 404, Atom.to_string(__MODULE__))
	end
end
