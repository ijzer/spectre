defmodule Spectre.API.Spectre.V1.System do
	use Maru.Router
	alias Plug.Conn

	get do
		conn
		|> Conn.send_resp(200, "hooray!")
	end
end
