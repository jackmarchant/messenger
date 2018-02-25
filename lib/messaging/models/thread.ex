defmodule Messaging.Models.Thread do
  use Ecto.Schema
  import Ecto.Changeset

  alias Messaging.Models.{Message, User}

  schema "thread" do
    field :name, :string
    
    has_many :messages, Message
    many_to_many :participants, User, join_through: "user_thread"

    timestamps()
  end

  def changeset(%__MODULE__{} = thread, attrs) do
    thread
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end