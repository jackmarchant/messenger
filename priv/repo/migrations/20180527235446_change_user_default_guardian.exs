defmodule Messaging.Repo.Migrations.ChangeUserDefaultGuardian do
  use Ecto.Migration

  def change do
    alter table(:user) do
      add :password_hash, :string
      remove :password
    end
  end
end
