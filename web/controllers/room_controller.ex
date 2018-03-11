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

  def edit(conn, %{"id" => room_id}) do
    room = Repo.get(Room, room_id)
    changeset = Room.changeset(room)

    render conn, "edit.html", changeset: changeset, room: room
  end

  def update(conn, %{"id" => room_id, "room" => room}) do
    old_room = Repo.get(Room, room_id)
    changeset = Room.changeset(old_room, room)

    case Repo.update(changeset) do
      {:ok, _room} ->
        conn
        |> put_flash(:info, "Room Updated")
        |> redirect(to: room_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, room: old_room
    end
  end
end
