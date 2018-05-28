defmodule Messaging.Models.Session do
  use Ecto.Schema
  import Ecto.Changeset

  alias Messaging.Models.User

  schema "session" do
    field :token, :string

    belongs_to :user, User

    timestamps()
  end

  def changeset(%__MODULE__{} = session, attrs) do
    session
    |> cast(attrs, [:token])
    |> put_assoc(:user, attrs[:user])
    |> validate_required([:token, :user])
  end
end
