defmodule Messaging.Repo.Migrations.AddSessionTable do
  use Ecto.Migration

  def change do
    create table(:session) do
      add :token, :string, size: 1024
      add :user_id, :integer

      timestamps()
    end
    create unique_index(:session, [:token])
  end
end
