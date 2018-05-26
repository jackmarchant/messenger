defmodule Messaging.Schema.Types.Thread do
  @moduledoc "GraphQL schema for a Thread"
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :classic

  import_types Messaging.Schema.Types.Message

  import Ecto.Query

  alias Messaging.Models.{Thread, UserThread, User, Message}
  alias Messaging.Repo

  def resolve_participants(%Thread{id: thread_id}, _, _) do
    participants =
      User
      |> from()
      |> join(
        :inner,
        [u],
        ut in UserThread,
        u.id == ut.user_id
      )
      |> where([_, ut], ut.thread_id == ^thread_id)
      |> Repo.all()

    {:ok, participants}
  end

  def resolve_messages(%Thread{id: thread_id}, _, _) do
    messages =
      Message
      |> from()
      |> where([m], m.thread_id == ^thread_id)
      |> Repo.all()

    {:ok, messages}
  end

  @desc "A Thread"
  node object :thread do
    field :name, :string
    field :slug, :string
    field :messages, list_of(:message), resolve: &resolve_messages/3
    field :participants, list_of(:user), resolve: &resolve_participants/3
  end
end
