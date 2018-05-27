defmodule Messaging.Models.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Messaging.Models.Thread
  alias Comeonin.Bcrypt

  schema "user" do
    field :email, :string
    field :password, :string
    field :firstname, :string
    field :lastname, :string
    field :role, :string

    many_to_many :threads, Thread, join_through: "user_thread"

    timestamps()
  end

  def changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, [:email, :firstname, :lastname, :role, :password])
    |> validate_required([:email, :firstname, :lastname, :role, :password])
    |> unique_constraint(:email)
    |> update_change(:password, &Bcrypt.hashpwsalt/1)
  end
end
