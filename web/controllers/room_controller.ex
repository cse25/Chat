defmodule Chat.RoomController do
  use Chat.Web, :controller

  alias Chat.Room

  def index(conn, _params) do
    rooms = Repo.all(Room)

    render conn, "index.html", rooms: rooms
  end

  def new(conn, _params) do
    changeset = Room.changeset(%Room{}, %{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"room" => room}) do
    changeset = Room.changeset(%Room{}, room)

    case Repo.insert(changeset) do
      {:ok, room} ->
        conn
        |> redirect(to: room_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end
end
