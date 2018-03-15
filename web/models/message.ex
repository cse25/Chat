defmodule Chat.Message do
  use Chat.Web, :model

  schema "messages" do
    field :message, :string
    belongs_to :user, Chat.User
    belongs_to :room, Chat.Room

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:message])
    |> validate_required([:message])
  end
end
