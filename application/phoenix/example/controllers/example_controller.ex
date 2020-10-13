defmodule Example.ExampleController do
    use ExampleWeb, :controller
  
    def index(conn, _params) do
      render conn, "index.json"
    end
  end
