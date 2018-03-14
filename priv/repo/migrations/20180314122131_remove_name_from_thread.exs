defmodule Messaging.Repo.Migrations.RemoveNameFromThread do
  use Ecto.Migration

  def change do
    alter table(:thread) do
      remove :name
    end
  end
end
