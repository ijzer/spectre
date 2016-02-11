defmodule Spectre.API.Subsonic do
  @moduledoc """
  Implements the Subsonic API. Currently uses a Plug pipeline to isolate
  API methods in separate modules because the Subsonic API is ridiculous
  and everything is a top-level resource. Authentication and other
  mandatory for all method parameters are also checked by a Plug loaded
  here.
  """
  use Plug.Router

  plug Plug.Logger

  plug Spectre.API.Subsonic.System
  
  plug :match
  plug :dispatch

  match _ do
    send_resp(conn, 404, Atom.to_string(__MODULE__))
  end

  @version "1.15.0"
  @spec response(atom, [tuple] | nil) :: iodata
  @doc """
  Loads the given payload into a response and converts it to xml.

  ## Examples

      iex> alias Spectre.API.Subsonic, as: API
      iex> API.response(:ok)
      "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<subsonic-response status=\"ok\" version=\"1.15.0\" xmlns=\"http://subsonic.org/restapi\"/>"
      iex> API.response(:ok, [{"license", 
      ...> %{valid: :true, email: "demo@subsonic.org"}}])
      "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<subsonic-response status=\"ok\" version=\"1.15.0\" xmlns=\"http://subsonic.org/restapi\">\n\t<license email=\"demo@subsonic.org\" valid=\"true\"/>\n</subsonic-response>"
  """
  def response(status, payload \\ nil) do
    XmlBuilder.doc("subsonic-response",
                   %{xmlns: "http://subsonic.org/restapi",
                     status: status,
                     version: @version},
                   payload)
  end
end
