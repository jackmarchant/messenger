defmodule Messaging.Repo.Migrations.CreateUsersThreads do
  use Ecto.Migration

  def change do
    create table(:user_thread) do
      add :user_id, references(:user)
      add :thread_id, references(:thread)
    end

    create unique_index(:user_thread, [:user_id, :thread_id])
  end
end
