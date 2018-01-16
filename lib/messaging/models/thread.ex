defmodule Messaging.Models.Thread do
  use Ecto.Schema
  import Ecto.Changeset

  alias Messaging.Models.Message

  schema "thread" do
    field :name, :string
    
    has_many :messages, Message

    timestamps()
  end

  def changeset(%__MODULE__{} = thread, attrs) do
    thread
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end