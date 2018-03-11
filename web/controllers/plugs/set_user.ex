defmodule Chat.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller

  alias Chat.Repo
  alias Chat.User

  def init(_params) do
  end

  def call(conn, _params) do
    user_id = get_session(conn, :user_id)

    # implicit return from cond statement returning conn object
    cond do
      user = user_id && Repo.get(User, user_id) ->
        assign(conn, :user, user)
        # conn.assigns[:user] => user struct
      true ->
        assign(conn, :user, nil)
    end
  end
end
