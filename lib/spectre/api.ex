defmodule Spectre.API do
  @moduledoc """
  Main entry point into the Spectre API.
  Requests to /api/* are for the Spectre API and are forwarded to
  Spectre.API.Spectre, requests to /subsonic/rest/* are for the Subsonic
  API layer and are forwarded to Spectre.API.Subsonic. The Subsonic API
  includes /rest/ because that is the location of the API in the Subsonic
  server and most clients have it hardcoded.
  """
  use Plug.Router

  plug Plug.Logger
  plug :match
  plug :dispatch

  forward "/api", to: Spectre.API.Spectre
  forward "/subsonic/rest", to: Spectre.API.Subsonic
  
  match _ do
    send_resp(conn, 404, Atom.to_string(__MODULE__))
  end
end
