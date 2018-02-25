defmodule Messaging.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :classic

  alias Absinthe.Relay.Node.ParseIDs

  import_types Absinthe.Type.Custom
  import_types Messaging.Schema.Types.Thread

  alias Messaging.Schema.Resolvers.User, as: UserResolver
  alias Messaging.Schema.Resolvers.Thread, as: ThreadResolver

  alias Messaging.Models.{User, Thread, Message}

  node interface do
    resolve_type fn
      %User{}, _ ->
        :user
      %Thread{}, _ ->
        :thread
      %Message{}, _ ->
        :message
      _, _ ->
        nil
    end
  end

  query do
    field :users, list_of(:user) do
      resolve &UserResolver.all/2
    end

    field :threads, list_of(:thread) do
      arg :user_id, :id
      
      middleware ParseIDs, user_id: :user
      resolve &ThreadResolver.all/2
    end
  end
end