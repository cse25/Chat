defmodule Chat.User do
  use Chat.Web, :model

  @derive {Poison.Encoder, only: [:personaname]}

  schema "users" do
    field :personaname, :string
    field :provider, :string
    field :steamid, :string
    has_many :rooms, Chat.Room
    has_many :messages, Chat.Message

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:personaname, :provider, :steamid])
    |> validate_required([:personaname, :provider, :steamid])
  end
end
