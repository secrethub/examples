defmodule Example.ExampleView do
    use ExampleWeb, :view
  
    def render("index.json", %{}) do
      if System.get_env("DEMO_USERNAME") != nil && System.get_env("DEMO_PASSWORD") != nil do
        %{message: "Hello, " <> System.get_env("DEMO_USERNAME") <> "!"}
      else 
        %{message: "not all the variables have been set"}
      end
    end
  end
