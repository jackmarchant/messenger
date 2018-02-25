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

  @desc "Queries"
  query do
    @desc "A list of users"
    field :users, list_of(:user) do
      resolve &UserResolver.all/2
    end

    @desc "A list of threads"
    field :threads, list_of(:thread) do
      arg :user_id, :id
      
      middleware ParseIDs, user_id: :user
      resolve &ThreadResolver.all/2
    end

    field :thread, :thread do
      resolve &ThreadResolver.find_thread/2
    end
  end

  @desc "Mutations"
  mutation(name: "Mutation") do
    @desc "Create a thread" 
    payload field :create_thread do
      input do
        field :user_id, non_null(:id)
        field :participants, list_of(non_null(:id))
        field :name, non_null(:string)
      end
      output do
        field :thread, :thread
      end

      middleware ParseIDs, user_id: :user, participants: :user
      resolve &ThreadResolver.create_thread/2
    end
  end
end