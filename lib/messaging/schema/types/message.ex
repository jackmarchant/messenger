defmodule Messaging.Schema.Types.Message do
  @moduledoc "GraphQL schema for a Message"
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :classic

  import_types Messaging.Schema.Types.User

  @desc "A Message can be sent as part of a thread between two users"
  object :message do
    field :content, :string
    field :sender, :user
  end
end
