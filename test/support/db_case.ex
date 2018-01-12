defmodule Messaging.DBCase do
  use ExUnit.CaseTemplate

  alias Ecto.Adapters.SQL.Sandbox

  using do
    quote do
      alias Ecto.Adapters.SQL.Sandbox
    end
  end

  setup_all do
    :ok = Sandbox.checkout(Messaging.Repo)
    Sandbox.mode(Messaging.Repo, {:shared, self()})

    :ok
  end
end