defmodule Messaging.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:message) do
      add :content, :string
      add :thread_id, :integer
      add :sender_id, :integer
      
      timestamps()
    end
  end
end
