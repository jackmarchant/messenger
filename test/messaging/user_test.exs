defmodule Messaging.UserTest do
  use ExUnit.Case, async: true
  use Messaging.DataCase

  import Messaging.Factory

  describe "Messaging.Models.User.changeset/2" do
    test "changeset is not valid" do
      _duplicate_email = insert(:user, %{email: "duplicate@email.com"})
      changeset = 
        %Messaging.Models.User{firstname: "Joe", lastname: "blogs", role: "user"}
        |> Messaging.Models.User.changeset(%{email: "duplicate@email.com"})

      {:error, result_cs} = Messaging.Repo.insert(changeset)
      assert "has already been taken" in errors_on(result_cs).email
      refute result_cs.valid?
    end
  end
end