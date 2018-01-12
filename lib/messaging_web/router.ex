defmodule MessagingWeb.Router do
  use MessagingWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: Messaging.Schema,
      interface: :simple
  end

  scope "/", MessagingWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end
end
