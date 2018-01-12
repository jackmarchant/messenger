defmodule Messaging.Factory do
  use ExMachina.Ecto, repo: Messaging.Repo

  def user_factory do
    %Messaging.User{
      firstname: "Jane",
      lastname: "Smith",
      email: sequence(:email, &"email-#{&1}@example.com"),
      inserted_at: DateTime.utc_now, 
      updated_at: DateTime.utc_now,
    }
  end
end