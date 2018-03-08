defmodule Chat.Repo.Migrations.Users do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :personaname, :string
      add :provider, :string
      add :steamid, :string

      timestamps()
    end
  end
end
