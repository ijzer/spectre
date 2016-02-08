defmodule Spectre.API.Spectre.V1 do
	alias Spectre.API.Spectre, as: API
	use Plug.Router

	plug Plug.Logger
	plug :match
	plug :dispatch

	get "/status" do
		conn
		|> resp(200, API.response(:ok))
		|> send_resp
	end

	match _ do
		conn
		|> resp(404,
						API.response(:error,
												 %{error: %{code: 404,
																	 message: "Couldn't find what you wanted",
																	 desc: "The resource you requested" <>
																	 "does not exist"}}))
		|> send_resp
	end
end
