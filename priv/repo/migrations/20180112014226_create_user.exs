defmodule Messaging.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :firstname, :string
      add :lastname, :string

      timestamps()
    end
    create unique_index(:users, [:email])
  end
end
