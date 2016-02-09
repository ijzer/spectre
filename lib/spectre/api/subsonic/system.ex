defmodule Spectre.API.Subsonic.System do
  use Plug.Router
  alias Spectre.API.Subsonic, as: API

  plug Plug.Logger
  plug :match
  plug :dispatch

  get "/ping.view", do: ping(conn)
  post "/ping.view", do: ping(conn)

  defp ping(conn) do
    conn
    |> resp(200, API.response(:ok))
    |> send_resp
    |> halt
  end

  get "/getLicense.view", do: get_license(conn)
  post "/getLicense.view", do: get_license(conn)

  @email Application.get_env(:spectre, :email, "")
  defp get_license(conn) do
    conn
    |> resp(200,
            API.response(:ok,
                         [{"license",
                           %{valid: :true,
                             email: @email,
                             trialExpires: "2013-12-19T21:13:01.344Z"}}]))
    |> send_resp
    |> halt
  end
  
  match _ do
    conn
  end
end
