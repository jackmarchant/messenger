defmodule Messaging.Models.Message do
  use Ecto.Schema
  import Ecto.Changeset

  alias Messaging.Models.{User, Thread}

  schema "message" do
    field :content, :string

    belongs_to :sender, User
    belongs_to :thread, Thread

    timestamps()
  end

  def changeset(%__MODULE__{} = message, attrs) do
    message
    |> cast(attrs, [:content])
    |> validate_required([:content])
    |> cast_assoc(:thread)
  end
end