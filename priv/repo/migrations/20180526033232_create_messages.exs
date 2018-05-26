defmodule Messaging.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:message) do
      add :content, :string
      add :sender_id, :integer
      add :thread_id, :integer

      timestamps()
    end
  end
end
