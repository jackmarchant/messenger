defmodule Messaging.Models.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field :email, :string
    field :firstname, :string
    field :lastname, :string
    field :role, :string

    timestamps()
  end

  def changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, [:email, :firstname, :lastname, :role])
    |> validate_required([:email, :firstname, :lastname, :role])
    |> unique_constraint(:email)
  end
end