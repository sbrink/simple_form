defmodule SimpleFormTest do
  use ExUnit.Case
  doctest SimpleForm

  test "greets the world" do
    assert SimpleForm.hello() == :world
  end
end
