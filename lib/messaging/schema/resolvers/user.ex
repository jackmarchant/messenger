defmodule Messaging.Schema.Resolvers.User do
  alias Messaging.{Repo, Models}

  import Ecto.Query

  def all(_, _) do
    users = 
      Models.User
      |> from
      |> where([u], u.role == "user")
      |> Repo.all

    {:ok, users}
  end
end