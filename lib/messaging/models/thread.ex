defmodule Messaging.Models.Thread do
  use Ecto.Schema
  import Ecto.Changeset

  alias Messaging.Models.{Message, User}

  schema "thread" do
    field :slug, :string

    has_many :messages, Message
    many_to_many :participants, User, join_through: "user_thread"

    timestamps()
  end

  def changeset(%__MODULE__{} = thread, attrs \\ %{}) do
    thread
    |> cast(attrs, [:slug])
    |> put_assoc(:participants, attrs[:participants])
    |> validate_required([:slug, :participants])
  end

  def generate_slug do
    DateTime.utc_now()
    |> DateTime.to_unix()
    |> Integer.to_string()
  end
end
