defmodule Spectre.API.Spectre.SystemTest do
	use ExUnit.Case
	use Plug.Test

	@opts Spectre.API.init([])

	test "/status" do
		conn = conn(:get, "/api/v1/status")
		conn = Spectre.API.call(conn, @opts)

		assert conn.state == :sent
		assert conn.status == 200

		response = Poison.Parser.parse!(conn.resp_body)

		assert is_binary(response["server"])
		assert Regex.match?(~r/^\d+\.\d+\.\d+$/, response["version"])
		assert response["status"] == "ok"
	end 

	test "resource not found" do
		conn = conn(:get, "/api/v1/notreal")
		conn = Spectre.API.call(conn, @opts)

		assert conn.state == :sent
		assert conn.status == 404

		response = Poison.Parser.parse!(conn.resp_body)

		assert response["status"] == "error"
		assert is_map(response["error"])

		error = response["error"]
		assert error["code"] == 404
		assert is_binary(error["message"])
		assert is_binary(error["desc"])
	end
end
