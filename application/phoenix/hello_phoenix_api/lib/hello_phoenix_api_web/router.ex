defmodule HelloPhoenixApiWeb.Router do
  use HelloPhoenixApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HelloPhoenixApi do
    pipe_through :api # Use the default browser stack

    get "/", HelloController, :index
  end

end