defmodule Chat.Message do
  use Chat.Web, :model

  schema "messages" do
    field :message, :string
    belongs_to :user, Chat.User
    belongs_to :room, Chat.Room

    timestamps()
  end
end
