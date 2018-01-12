defmodule Messaging.Models.Thread do
  use Ecto.Schema
  import Ecto.Changeset

  schema "thread" do
    field :name, :string

    timestamps()
  end

  def changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end