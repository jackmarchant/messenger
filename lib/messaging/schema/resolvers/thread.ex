defmodule Messaging.Schema.Resolvers.Thread do
  alias Messaging.Repo
  alias Messaging.Models.{Thread, UserThread, User, Message}

  import Ecto.Query

  def find_thread(%{slug: slug}, %{context: %{current_user: _current_user}}) do
    thread =
      Thread
      |> where([t], t.slug == ^slug)
      |> Repo.one()

    {:ok, thread}
  end
  def find_thread(_, _) do
    {:error, "Not authorised"}
  end

  def all(_, %{context: %{current_user: current_user}}) do
    threads =
      Thread
      |> join(
        :inner,
        [t],
        ut in UserThread,
        ut.thread_id == t.id
      )
      |> where([_, ut], ut.user_id == ^current_user.id)
      |> Repo.all()

    {:ok, threads}
  end
  def all(_, _) do
    {:error, "Not authorised"}
  end

  def create_thread(%{user_id: user_id}, %{context: %{current_user: current_user}}) do
    user_ids = [current_user.id, String.to_integer(user_id)]

    participants =
      User
      |> from()
      |> where([u], u.id in ^user_ids)
      |> Repo.all()

    thread =
      %Thread{}
      |> Thread.changeset(%{
        slug: Thread.generate_slug(),
        participants: participants,
      })
      |> Repo.insert!()

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

    case sender do
      nil -> {:error, "cannot create message, invalid user id"}
      sender ->
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
end
