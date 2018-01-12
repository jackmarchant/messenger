defmodule Messaging.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :email, :string
      add :firstname, :string
      add :lastname, :string
      add :role, :string

      timestamps()
    end
    create unique_index(:user, [:email])
  end
end
