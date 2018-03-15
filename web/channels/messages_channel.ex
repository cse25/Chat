defmodule Chat.MessagesChannel do
  use Chat.Web, :channel
  alias Chat.{Room, Message}

  def join("messages:" <> room_id, _params, socket) do
    room_id = String.to_integer(room_id)
    room = Repo.get(Room, room_id)

    {:ok, %{}, assign(socket, :room, room)}
    # possible returned touples:
    # {:ok, socket}
    # {:ok, %{}, socket}
    # {:error, map}
  end

  def handle_in(name, %{"message" => message}, socket) do
    room = socket.assigns.room

    changeset = room
      |> build_assoc(:messages)
      |> Message.changeset(%{message: message})

    case Repo.insert(changeset) do
      {:ok, message} ->
        {:reply, :ok, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
    # {:reply, :ok, socket}
  end
end
