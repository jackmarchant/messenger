defmodule Messaging.UserTest do
  use ExUnit.Case
  use Messaging.DataCase
  use Messaging.DBCase

  import Messaging.Factory

  describe "Messaging.User.changeset/2" do
    test "changeset is not valid" do
      _duplicate_email = insert(:user, %{email: "duplicate@email.com"})
      changeset = 
        %Messaging.User{firstname: "Joe", lastname: "blogs"}
        |> Messaging.User.changeset(%{email: "duplicate@email.com"})

      {:error, result_cs} = Messaging.Repo.insert(changeset)
      assert "has already been taken" in errors_on(result_cs).email
      refute result_cs.valid?
    end
  end
end