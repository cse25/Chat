defmodule Chat.User do
  use Chat.Web, :model

  schema "users" do
    field :personaname, :string
    field :provider, :string
    field :steamid, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:personaname, :provider, :steamid])
    |> validate_required([:personaname, :provider, :steamid])
  end
end
