defmodule Messaging.Schema.Types.User do
  @moduledoc "GraphQL schema for a User"
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :classic

  @desc "A user"
  object :user do
    field :email, :string
    field :firstname, :string
    field :lastname, :string
    field :role, :string
  end
end
