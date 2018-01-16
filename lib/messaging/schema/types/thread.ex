defmodule Messaging.Schema.Types.Thread do
  @moduledoc "GraphQL schema for a Thread"
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :classic

  import_types Messaging.Schema.Types.Message

  @desc "A Thread"
  object :thread do
    field :name, :string
    field :messages, list_of(:message)
  end
end
