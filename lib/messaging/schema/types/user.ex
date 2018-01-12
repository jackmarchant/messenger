defmodule Messaging.Schema.Types.User do
  @moduledoc "GraphQL schema for a User"
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :classic

  @desc "A user can have a role of `user` or `admin`"
  enum :role do
    value :user
    value :admin
  end

  @desc "A user"
  object :user do
    field :email, :string
    field :firstname, :string
    field :lastname, :string
    field :role, :role
  end
end
