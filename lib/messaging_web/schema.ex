defmodule MessagingWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :classic

  alias Absinthe.Relay.Node.ParseIDs

  import_types Absinthe.Type.Custom
  import_types Messaging.Schema.Types.Thread
  import_types Messaging.Schema.Types.Session

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
  query(name: "Query") do
    @desc "A list of users"
    field :users, list_of(:user) do
      resolve &UserResolver.all/2
    end

    field :user, :user do
      arg :token, :string

      resolve &UserResolver.find_by_token/2
    end

    @desc "A list of threads"
    field :threads, list_of(:thread) do
      arg :user_id, :id

      middleware ParseIDs, user_id: :user
      resolve &ThreadResolver.all/2
    end

    @desc "A single thread by slug"
    field :thread, :thread do
      arg :slug, :string

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
      end
      output do
        field :thread, :thread
      end

      middleware ParseIDs, user_id: :user
      resolve &ThreadResolver.create_thread/2
    end

    @desc "Create a message"
    payload field :create_message do
      input do
        field :user_id, non_null(:id)
        field :thread_id, non_null(:id)
        field :content, non_null(:string)
      end
      output do
        field :thread, :thread
        field :message, :message
      end

      middleware ParseIDs, user_id: :user, thread_id: :thread
      resolve &ThreadResolver.create_message/2
    end

    @desc "Create a user"
    payload field :create_user do
      input do
        field :firstname, non_null(:string)
        field :lastname, non_null(:string)
        field :email, non_null(:string)
        field :password, non_null(:string)
      end
      output do
        field :user, :user
      end
      resolve &UserResolver.create_user/2
    end

    @desc "User login"
    payload field :login do
      input do
        field :email, non_null(:string)
        field :password, non_null(:string)
      end
      output do
        field :session, :session
      end
      resolve &UserResolver.login/2
    end
  end
end
