defmodule Messaging.Repo.Migrations.RemoveUniqueNameIndex do
  use Ecto.Migration

  def change do
    drop unique_index(:thread, [:name])
  end
end
