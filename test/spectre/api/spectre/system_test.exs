Code.require_file("test/test_helper.exs")

defmodule Spectre.API.Spectre.SystemTest do
	use Amrita.Sweet
	use Plug.Test

	@opts Spectre.API.Spectre.init([])

		facts "server tests" do

		fact "/status" do
			conn = conn(:get, "/api/v1/status")
			conn = Spectre.API.Router.call(conn, @opts)

			conn.state |> equals(:sent)
			conn.status |> equals(200)

			response = Poison.Parser.parse!(conn.resp_body)

			response["server"] |> equals("spectre")
			response["version"] |> equals("0.0.1")
			response["status"] |> equals("ok")
		end
	end
end
