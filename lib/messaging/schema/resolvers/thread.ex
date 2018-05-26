defmodule Messaging.Schema.Resolvers.Thread do
  alias Messaging.Repo
  alias Messaging.Models.{Thread, UserThread, User, Message}

  import Ecto.Query

  def find_thread(%{slug: slug}, _) do
    thread =
      Thread
      |> where([t], t.slug == ^slug)
      |> Repo.one()

    {:ok, thread}
  end

  def all(%{user_id: user_id}, _) do
    uid = String.to_integer(user_id)
    threads =
      Thread
      |> join(
        :inner,
        [t],
        ut in UserThread,
        ut.user_id == ^uid
      )
      |> Repo.all()

    {:ok, threads}
  end

  def all(_, _) do
    threads =
      Thread
      |> Repo.all()

    {:ok, threads}
  end

  def create_thread(%{user_id: creator_id, participants: participants}, _) do
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
      %Thread{}
      |> Thread.changeset()
      |> Repo.insert!()
      |> Repo.preload(:participants)
      |> Ecto.Changeset.change()
      |> Ecto.Changeset.put_assoc(:participants, users)
      |> Repo.update!()

    {:ok, %{thread: thread}}
  end

  def create_message(%{content: content, user_id: sender_id, thread_id: thread_id}, _) do
    t_id = String.to_integer(thread_id)
    s_id = String.to_integer(sender_id)

    thread =
      Thread
      |> where([t], t.id == ^t_id)
      |> Repo.one()

    sender =
      User
      |> where([u], u.id == ^s_id)
      |> Repo.one()

    message =
      %Message{
        thread: thread,
        sender: sender,
        content: content
      }
      |> Repo.insert!()

    {:ok, %{thread: thread, message: message}}
  end
end
