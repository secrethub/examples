defmodule HelloPhoenixApi.HelloController do
    use HelloPhoenixApiWeb, :controller
  
    def index(conn, _params) do
      render conn, "index.json"
    end
  end
