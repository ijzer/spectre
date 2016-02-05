Code.require_file("test/test_helper.exs")

defmodule Spectre.API.Subsonic.SystemTest do
	use Amrita.Sweet
	use Plug.Test

	@opts Spectre.API.Subsonic.init([])

		facts "subsonic server tests" do
		import SweetXml

		fact "/ping.view" do
			conn = conn(:get, "/subsonic/rest/ping.view")
			conn = Spectre.API.Subsonic.call(conn, @opts)

			conn.state |> equals(:sent)
			conn.status |> equals(200)

			response =
				conn.resp_body
  			|> xpath(
			    ~x"//subsonic-response",
					status: ~x"./@status"s,
					version: ~x"./@version"s)

			response[:status] |> equals("ok")
			response[:version] |> equals("0.0.1")
		end

		fact "/getLicense.view" do
			conn = conn(:get, "/subsonic/rest/getLicense.view")
			conn = Spectre.API.Subsonic.call(conn, @opts)

			conn.state |> equals(:sent)
			conn.status |> equals(200)

			response =
				conn.resp_body
			  |> xpath(
				  ~x"//subsonic-response/license",
					valid: ~x"./@valid"s,
					email: ~x"./@email"s)

			response[:valid] |> equals("true")
			response[:email] |> truthy
		end
	end
end
