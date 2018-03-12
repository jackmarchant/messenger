defmodule MessagingWeb.ThreadController do
  use MessagingWeb, :controller

  def show(conn, params) do
    props = %{
      slug: params["slug"]
    }
    render conn, "index.html", props: props
  end
end
