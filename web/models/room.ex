defmodule Chat.Room do
  use Chat.Web, :model

  schema "rooms" do
    field :room, :string
    belongs_to :user, Chat.User
    has_many :message, Chat.Messages

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:room])
    |> validate_required([:room])
  end
end
