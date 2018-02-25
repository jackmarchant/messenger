defmodule Messaging.Schema.Types.Message do
  @moduledoc "GraphQL schema for a Message"
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :classic

  alias Messaging.Repo
  alias Messaging.Models.{Message, User}

  import_types Messaging.Schema.Types.User

  def resolve_sender(%Message{sender_id: sender_id}, _, _) do
    {:ok, Repo.get(User, sender_id)}
  end

  @desc "A Message can be sent as part of a thread between two users"
  node object :message do
    field :content, :string
    field :sender, :user, resolve: &resolve_sender/3
  end
end
