defmodule Chat.Repo.Migrations.Messages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :message, :string
      add :user_id, references(:users)

      timestamps()
    end
  end
end
