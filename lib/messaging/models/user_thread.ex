defmodule Messaging.Models.UserThread do
  use Ecto.Schema

  schema "user_thread" do
    field :user_id, :integer
    field :thread_id, :integer
  end
end