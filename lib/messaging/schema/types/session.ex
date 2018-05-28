defmodule Messaging.Schema.Types.Session do
  @moduledoc "GraphQL schema for a Session"
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :classic

  @desc "A session"
  node object :session do
    field :token, :string
  end
end
