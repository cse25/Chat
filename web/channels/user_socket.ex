defmodule Chat.UserSocket do
  use Phoenix.Socket

  channel "messages:*", Chat.MessagesChannel

  transport :websocket, Phoenix.Transports.WebSocket

  def connect(%{"token" => token}, socket) do
    IO.puts("CONNECTED")
    case Phoenix.Token.verify(socket, "key", token) do
      {:ok, user_id} ->
        {:ok, assign(socket, :user_id, user_id)}
      {:error, _error} ->
        :error
    end
  end

  def id(_socket), do: nil
end
