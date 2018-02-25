defmodule Messaging.Schema.Types.User do
  @moduledoc "GraphQL schema for a User"
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :classic

  alias Messaging.Repo
  alias Messaging.Models.{Thread, User, UserThread}

  import Ecto.Query

  def resolve_threads(%User{id: user_id}, _, _) do
    threads = 
      Thread
      |> from()
      |> join(
        :inner,
        [t],
        ut in UserThread,
        t.id == ut.thread_id
      )
      |> where([_, ut], ut.user_id == ^user_id)
      |> Repo.all()

    {:ok, threads}
  end

  @desc "A user"
  node object :user do
    field :id, :id
    field :email, :string
    field :firstname, :string
    field :lastname, :string
    field :role, :string
    field :threads, list_of(:thread), resolve: &resolve_threads/3
  end
end
