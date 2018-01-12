defmodule Messaging.Schema.Resolvers.User do
  alias Messaging.{Repo, User}

  def all(_, _) do
    {:ok, Repo.all(User)}
  end
end