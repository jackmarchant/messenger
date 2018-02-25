defmodule Messaging.Repo.Migrations.CreateThread do
  use Ecto.Migration

  def change do
    create table(:thread) do
      add :name, :string
      
      timestamps()
    end
    create unique_index(:thread, [:name])
  end
end
