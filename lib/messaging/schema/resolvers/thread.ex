defmodule Messaging.Schema.Resolvers.Thread do
  alias Messaging.Repo
  alias Messaging.Models.{Thread, UserThread, User}

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

  def create_thread(%{name: name, user_id: creator_id, participants: participants}, _) do
    user_ids = 
      [creator_id]
      |> Enum.concat(participants)
      |> Enum.map(&String.to_integer/1)

    users = 
      User
      |> from()
      |> where([u], u.id in ^user_ids)
      |> Repo.all()

    thread =
      %Thread{name: name}
      |> Repo.insert!()
      |> Repo.preload(:participants)
      |> Ecto.Changeset.change()
      |> Ecto.Changeset.put_assoc(:participants, users)
      |> Repo.update!()

    {:ok, %{thread: thread}}
  end
end