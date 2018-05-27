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

  def create_user(%{email: _, firstname: _, lastname: _, password: _} = attrs, _) do
    user_attrs = Map.merge(%{role: "member"}, Map.take(attrs, [:email, :firstname, :lastname, :password]))
    user =
      %Models.User{}
      |> Models.User.changeset(user_attrs)
      |> Repo.insert!()

    {:ok, %{user: user}}
  end
end
