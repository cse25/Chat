defmodule Chat.MessagesChannel do
  use Chat.Web, :channel

  alias Chat.{Room, Message}

  def join("messages:" <> room_id, _params, socket) do
    room_id = String.to_integer(room_id)
    room = Room
      |> Repo.get(room_id)
      |> Repo.preload(:messages)

    IO.inspect(room)

    {:ok, %{messages: room.messages}, assign(socket, :room, room)}
  end

  def handle_in(name, %{"message" => message}, socket) do
    room = socket.assigns[:room]

    changeset = room
      |> build_assoc(:messages)
      |> Message.changeset(%{message: message})

    case Repo.insert(changeset) do
      {:ok, message} ->
        broadcast!(socket, "messages:#{socket.assigns[:room].id}:new",
          %{message: message}
        )
        {:reply, :ok, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end
end
