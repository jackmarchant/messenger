defmodule Messaging.Factory do
  use ExMachina.Ecto, repo: Messaging.Repo

  alias Messaging.Models.{User}

  def user_factory do
    %User{
      firstname: "Jane",
      lastname: "Smith",
      email: sequence(:email, &"email-#{&1}@example.com"),
      role: "user",# admin/user
      inserted_at: DateTime.utc_now, 
      updated_at: DateTime.utc_now,
    }
  end

  def make_admin(%User{} = user) do
    %User{user | role: "admin"}
  end
end