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

  pipeline :graphql do
    plug Guardian.Plug.Pipeline, module: Messaging.Guardian, error_handler: MessagingWeb.AuthErrorHandler
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
    plug MessagingWeb.ContextPlug
  end

  scope "/" do
    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: MessagingWeb.Schema,
      interface: :simple

    pipe_through :graphql
    forward "/graphql", Absinthe.Plug, schema: MessagingWeb.Schema
  end

  scope "/", MessagingWeb do
    pipe_through [:browser]

    get "/", PageController, :index
    get "/thread/:slug", ThreadController, :show
    get "/signup", PageController, :index
    get "/login", PageController, :index
  end
end
