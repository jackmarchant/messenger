defmodule Messaging.Repo.Migrations.AddPasswordToUser do
  use Ecto.Migration

  def change do
    alter table(:user) do
      add :password, :string
    end
  end
end
