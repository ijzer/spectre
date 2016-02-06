defmodule Spectre.API.Subsonic.SystemTest do
	use ExUnit.Case
	use Plug.Test
	import SweetXml
	
	@opts Spectre.API.init([])

	test "/ping.view" do
		conn = conn(:get, "/subsonic/rest/ping.view")
		conn = Spectre.API.call(conn, @opts)

		assert conn.state == :sent
		assert conn.status == 200

		response =
			conn.resp_body
    	|> xpath(
	  		~x"//subsonic-response",
				status: ~x"./@status"s,
				version: ~x"./@version"s)

		assert response[:status] == "ok"
		assert Regex.match?(~r/^\d+\.\d+\.\d+$/, response[:version])
	end

	test "/getLicense.view" do
		conn = conn(:get, "/subsonic/rest/getLicense.view")
		conn = Spectre.API.call(conn, @opts)

		assert conn.state == :sent
		assert conn.status == 200

		response =
			conn.resp_body
  		|> xpath(
	  		~x"//subsonic-response/license",
				valid: ~x"./@valid"s,
				email: ~x"./@email"s)

		assert response[:valid] == "true"
		assert is_binary(response[:email])
	end

	test "resource not found" do
		conn = conn(:get, "/subsonic/rest/notReal.view")
		conn = Spectre.API.call(conn, @opts)

		assert conn.state == :sent
		assert conn.status == 404
	end
end
