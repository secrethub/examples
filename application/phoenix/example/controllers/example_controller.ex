defmodule Example.ExampleController do
    use ExampleWeb, :controller
  
    def index(conn, _params) do
      text conn, response()
    end

    def response() do
      if System.get_env("DEMO_USERNAME") != nil && System.get_env("DEMO_PASSWORD") != nil do
        "Hello, " <> System.get_env("DEMO_USERNAME") <> "!"
      else 
        "not all the variables have been set"
      end
    end
  end
