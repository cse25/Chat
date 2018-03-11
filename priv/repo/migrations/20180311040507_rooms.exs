defmodule Chat.Repo.Migrations.Rooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :room, :string
      add :user_id, references(:users)

      timestamps()
    end
  end
end
