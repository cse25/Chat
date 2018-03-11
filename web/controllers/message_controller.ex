defmodule Chat.MessageController do
  use Chat.Web, :controller

  alias Chat.Message

  def index(conn, _params) do
    messages = Repo.all(Message)

    render conn, "index.html", messages: messages
  end

  def new(conn, _params) do
    changeset = Message.changeset(%Message{}, %{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"message" => message}) do
    changeset = Message.changeset(%Message{}, message)

    case Repo.insert(changeset) do
      {:ok, message} ->
        conn
        |> redirect(to: message_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end
end
