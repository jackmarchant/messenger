defmodule Messaging.Models.Thread do
  use Ecto.Schema
  import Ecto.Changeset

  alias Messaging.Models.{Message, User}

  schema "thread" do
    field :name, :string
    field :slug, :string
    
    has_many :messages, Message
    many_to_many :participants, User, join_through: "user_thread"

    timestamps()
  end

  def changeset(%__MODULE__{} = thread, attrs \\ %{}) do
    thread
    |> generate_slug()
    |> cast(attrs, [:name])
    |> validate_required([:name, :slug])
  end

  defp generate_slug(%__MODULE__{} = thread) do
    slug = 
      DateTime.utc_now() 
      |> DateTime.to_unix()
      |> Integer.to_string()

    %{thread | slug: slug}
  end
end