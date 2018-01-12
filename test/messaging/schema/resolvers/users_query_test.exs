defmodule Messaging.UsersQueryTest do
  use ExUnit.Case
  use Messaging.DBCase

  alias Messaging.Schema.Resolvers.User, as: UserResolver

  import Messaging.Factory

  setup do
    users = [
      insert(:user, %{
        email: "test@person.com", 
        firstname: "test", 
        lastname: "damon"
      }),
      insert(:user)
    ]

    %{
      users: users
    }
  end

  describe "Messaging.Schema.Resolvers.Users.all/2" do
    test "can find all users", %{users: users} do
      {:ok, results} = UserResolver.all(%{}, %{})
      %Messaging.User{
        email: email, 
        firstname: firstname, 
        lastname: lastname
      } = List.first(results)

      assert email == "test@person.com"
      assert firstname == "test"
      assert lastname == "damon"

      assert length(results) == length(users)
    end
  end
end