defmodule Messaging.Schema.Resolvers.User do
  alias Messaging.{Repo, Models}

  import Ecto.Query

  def all(_, %{context: %{current_user: _}}) do
    users =
      Models.User
      |> from
      |> where([u], u.role == "user")
      |> Repo.all

    {:ok, users}
  end

  def all(_args, _info) do
    {:error, "Not Authorized"}
  end

  def find_by_token(%{token: token}, _) do
    user =
      Models.User
      |> join(:inner, [u], s in Models.Session, s.user_id == u.id)
      |> where([_, s], s.token == ^token)
      |> select([u], u)
      |> Repo.one()

    {:ok, user}
  end

  def create_user(%{email: _, firstname: _, lastname: _, password: _} = attrs, _) do
    user_attrs = Map.merge(%{role: "member"}, Map.take(attrs, [:email, :firstname, :lastname, :password]))
    user =
      %Models.User{}
      |> Models.User.changeset(user_attrs)
      |> Repo.insert!()

    {:ok, %{user: user}}
  end

  def login(params, _info) do
    with {:ok, user} <- Messaging.Session.authenticate(params),
        {:ok, token, _ } <- Messaging.Guardian.encode_and_sign(user),
    do: {:ok, %{session: Messaging.Session.create_session(user, token)}}
  end
end
