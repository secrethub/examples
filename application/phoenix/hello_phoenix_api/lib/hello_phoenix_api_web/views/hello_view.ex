defmodule HelloPhoenixApi.HelloView do
    use HelloPhoenixApiWeb, :view
  
    def render("index.json", %{}) do
      %{hello: if(System.get_env("DEMO_USERNAME") != "" && System.get_env("DEMO_PASSWORD") != "", do: System.get_env("DEMO_USERNAME"), else: "stranger")}
    end
  end