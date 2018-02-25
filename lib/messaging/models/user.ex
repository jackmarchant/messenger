defmodule Messaging.Models.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Messaging.Models.Thread

  schema "user" do
    field :email, :string
    field :firstname, :string
    field :lastname, :string
    field :role, :string

    many_to_many :threads, Thread, join_through: "user_thread"

    timestamps()
  end

  def changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, [:email, :firstname, :lastname, :role])
    |> validate_required([:email, :firstname, :lastname, :role])
    |> unique_constraint(:email)
  end
end