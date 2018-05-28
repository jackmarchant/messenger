defmodule Seeder do
  alias Messaging.{Repo, Models}

  defp insert(:message, attrs) do
    %Models.Message{}
    |> Models.Message.changeset(attrs)
    |> Repo.insert!()
  end

  defp insert(:thread, attrs) do
    %Models.Thread{}
    |> Models.Thread.changeset(attrs)
    |> Repo.insert!()
  end

  defp insert(:user, attrs) do
    %Models.User{}
    |> Models.User.changeset(attrs)
    |> Repo.insert!()
  end

  def run do
    Repo.delete_all(Models.UserThread)
    Repo.delete_all(Models.User)
    Repo.delete_all(Models.Thread)
    Repo.delete_all(Models.Message)

    insert(:user, %{
      email: "joeblogs@email.com",
      password: "hellworld",
      firstname: "joe",
      lastname: "blogs",
      role: "user",
    })

    insert(:user, %{
      email: "mattdamon@email.com",
      password: "benaffleck",
      firstname: "matt",
      lastname: "damon",
      role: "user"
    })

    user_one = insert(:user, %{
      email: "benaffleck@email.com",
      password: "mattdamon",
      firstname: "ben",
      lastname: "affleck",
      role: "user"
    })

    user_two = insert(:user, %{
      email: "jack@jackmarchant.com",
      password: "password123",
      firstname: "jack",
      lastname: "marchant",
      role: "admin"
    })

    thread = insert(:thread, %{
      slug: Models.Thread.generate_slug(),
      participants: [user_one, user_two]
    })

    insert(:message, %{
      thread: thread,
      sender: user_two,
      content: "Hey, this is a message on a thread."
    })

    insert(:message, %{
      thread: thread,
      sender: user_one,
      content: "Hey, I am responding to your message."
    })
  end
end

Seeder.run()
