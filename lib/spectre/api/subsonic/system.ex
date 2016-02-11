defmodule Spectre.API.Subsonic.System do
  @moduledoc """
  API methods categorized in the [Subsonic API spec](subsonic.org/pages/api.jsp)
  as being system methods.
  """
  use Plug.Router
  alias Spectre.API.Subsonic, as: API

  plug Plug.Logger
  plug :match
  plug :dispatch

  get "/ping.view", do: ping(conn)
  post "/ping.view", do: ping(conn)
  
  @doc """
  Queries the status of the server.
  """
  defp ping(conn) do
    conn
    |> resp(200, API.response(:ok))
    |> send_resp
    |> halt
  end

  get "/getLicense.view", do: get_license(conn)
  post "/getLicense.view", do: get_license(conn)

  @email Application.get_env(:spectre, :email, "")
  @doc """
  Checks the license status of the server. Because Spectre does not use a
  licensing scheme, this response is hardcoded so that Subsonic clients
  will think the server has a valid license.
  """
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
