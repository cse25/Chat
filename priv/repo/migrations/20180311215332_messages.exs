defmodule Chat.Repo.Migrations.Messages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :message, :string
      add :user_id, references(:users)
      add :room_id, references(:rooms)

      timestamps()
    end
  end
end
