defmodule Spectre.API do
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
