defmodule Messaging.Session do
  @moduledoc """
  Context functions for managing a session
  """
  alias Messaging.Models.{User, Session}
  alias Messaging.Repo

  def authenticate(%{email: email, password: password}) do
    user = Repo.get_by(User, email: String.downcase(email))
    case check_password(user, password) do
      true -> {:ok, user}
      _ -> {:error, "Incorrect login credentials"}
    end
  end
  def authenticate(_), do: {:error, "email and password required"}

  def create_session(user, token) do
    %Session{}
    |> Session.changeset(%{user: user, token: token})
    |> Repo.insert!()
  end

  defp check_password(user, password) do
    case user do
      nil -> false
      _ -> Comeonin.Bcrypt.checkpw(password, user.password_hash)
    end
  end
end
