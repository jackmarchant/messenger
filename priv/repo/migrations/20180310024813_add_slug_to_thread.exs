defmodule Messaging.Repo.Migrations.AddSlugToThread do
  use Ecto.Migration

  def change do
    alter table(:thread) do
      add :slug, :string
    end
  end
end