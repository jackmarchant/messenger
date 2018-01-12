defmodule Messaging.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :firstname, :string
    field :lastname, :string

    timestamps()
  end

  def changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, [:email, :firstname, :lastname])
    |> validate_required([:email, :firstname, :lastname])
    |> unique_constraint(:email)
  end
end