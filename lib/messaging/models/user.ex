defmodule Messaging.Models.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Messaging.Models.Thread
  alias Comeonin.Bcrypt

  schema "user" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
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
    |> generate_password_hash()
  end

  defp generate_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end
