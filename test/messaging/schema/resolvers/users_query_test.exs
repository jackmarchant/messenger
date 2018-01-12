defmodule Messaging.UsersQueryTest do
  use ExUnit.Case, async: true

  alias Ecto.Adapters.SQL.Sandbox
  alias Messaging.Schema.Resolvers.User, as: UserResolver

  import Messaging.Factory

  setup do
    :ok = Sandbox.checkout(Messaging.Repo)
    Sandbox.mode(Messaging.Repo, {:shared, self()})
    
    insert(:user)
    :ok
  end

  describe "Messaging.Schema.Resolvers.Users.all/2" do
    test "can find all users" do
      %Messaging.Models.User{
        email: email, 
        firstname: firstname, 
        lastname: lastname
      } = insert(:user, %{
        email: "test@person.com", 
        firstname: "test", 
        lastname: "damon",
        role: "user",
      })
      {:ok, results} = UserResolver.all(%{}, %{})

      assert email == "test@person.com"
      assert firstname == "test"
      assert lastname == "damon"

      assert length(results) == 2
    end

    test "it doesn't find any admins" do
      admin_user = insert(:user) |> make_admin
      {:ok, results} = UserResolver.all(%{}, %{})

      assert admin_user not in results
    end
  end
end