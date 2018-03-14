defmodule Chat.MessagesChannel do
  use Chat.Web, :channel
  alias Chat.Room

  def join("messages:" <> room_id, _params, socket) do
    room_id = String.to_integer(room_id)
    room = Repo.get(Room, room_id)

    {:ok, %{}, socket}
    # possible returned touples:
    # {:ok, socket}
    # {:ok, %{}, socket}
    # {:error, map}
  end

  def handle_in(name, message, socket) do
    {:reply, :ok, socket}
  end
end
