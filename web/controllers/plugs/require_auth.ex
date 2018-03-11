defmodule Chat.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias Chat.Router.Helpers

  def init() do
  end

  # params object is whatever is returned from init function
  def call(conn, _params) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in")
      |> redirect(to: Helpers.message_path(conn, :index))
      |> halt()
    end
  end
end
