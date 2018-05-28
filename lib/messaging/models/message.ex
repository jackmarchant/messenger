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
    |> put_assoc(:thread, attrs[:thread])
    |> put_assoc(:sender, attrs[:sender])
    |> validate_required([:content, :thread, :sender])
  end
end
