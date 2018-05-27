defmodule MessagingWeb.ContextPlug do
  @moduledoc """
  Add contextual data to the conn, mainly the current user
  """
  @behaviour Plug
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} -> put_private(conn, :absinthe, %{context: context})
    end
  end

  @doc """
  Return the current user context based on the authorisation header
  """
  def build_context(conn) do
    current_user =
      conn
      |> fetch_session()
      |> get_session(:current_user)

    {:ok, %{current_user: current_user}}
  end
end
