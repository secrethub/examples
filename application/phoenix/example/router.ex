defmodule ExampleWeb.Router do
  use ExampleWeb, :router

  pipeline :api do
    plug :accepts, ["html"]
  end

  scope "/", Example do
    pipe_through :api # Use the default browser stack

    get "/", ExampleController, :index
  end

end
