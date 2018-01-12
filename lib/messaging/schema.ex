defmodule Messaging.Schema do

  use Absinthe.Schema
  use Absinthe.Relay.Schema, :classic

  # alias Absinthe.Relay.Node.ParseIDs

  import_types Absinthe.Type.Custom
  import_types Messaging.Schema.Types.User

  alias Messaging.Schema.Resolvers.User, as: UserResolver

  query do
    field :users, list_of(:user) do
      resolve &UserResolver.all/2
    end
  end
end