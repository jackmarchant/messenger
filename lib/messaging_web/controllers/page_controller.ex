defmodule MessagingWeb.PageController do
  use MessagingWeb, :controller

  def index(conn, _params) do
    props = %{}
    render conn, "index.html", props: props
  end
end
