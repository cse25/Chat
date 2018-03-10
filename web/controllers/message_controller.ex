defmodule Chat.MessageController do
  use Chat.Web, :controller

  alias Chat.Message

  def index(conn, _params) do
    render conn, "index.html"
  end

  def new(conn, _params) do
    changeset = Message.changeset(%Message{}, %{})

    render conn, "new.html", changeset: changeset
  end

end
