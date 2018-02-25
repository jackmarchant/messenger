defmodule Messaging.Schema.Resolvers.Thread do
  alias Messaging.Repo
  alias Messaging.Models.{Thread, UserThread}

  import Ecto.Query

  def all(%{user_id: user_id}, _) do
    uid = String.to_integer(user_id)

    threads = 
      Thread
      |> from()
      |> join(
        :inner,
        [t],
        ut in UserThread,
        ut.user_id == ^uid
      )
      |> Repo.all

    {:ok, threads}
  end

  def all(_, _) do
    threads = 
      Thread
      |> from()
      |> Repo.all()

    {:ok, threads}
  end
end