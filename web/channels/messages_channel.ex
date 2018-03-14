defmodule Chat.MessagesChannel do
  use Chat.Web, :channel

  def join(name, _params, socket) do
    IO.puts(name)
    # get list of messages

    {:ok, %{hey: "there"}, socket}
    # possible returned touples:
    # {:ok, socket}
    # {:ok, %{}, socket}
    # {:error, map}
  end

  def handle_in(name, message, socket) do
    {:reply, :ok, socket}
  end
end
