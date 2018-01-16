defmodule Messaging.Models.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Messaging.Models.Thread

  schema "user" do
    field :email, :string
    field :firstname, :string
    field :lastname, :string
    field :role, :string

    has_many :threads, Thread

    timestamps()
  end

  def changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, [:email, :firstname, :lastname, :role])
    |> validate_required([:email, :firstname, :lastname, :role])
    |> unique_constraint(:email)
  end
end