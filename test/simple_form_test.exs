defmodule SimpleFormTest do
  use ExUnit.Case
  import Phoenix.HTML
  import SimpleForm

  doctest SimpleForm

  describe "build" do
    test "should build a input" do
      opts = []
      opts = Keyword.put(opts, :_style, SimpleForm.Styles.Bootstrap4)
      opts = Keyword.put(opts, :_translate_error_fn, fn x -> x end)

      form_input = input(
        %Phoenix.HTML.Form{
          impl: Phoenix.HTML.FormData.Ecto.Changeset,
          source: %{types: %{name: :string}, required: [], validations: [], data: %{}, changes: %{}}
        },
        :name,
        opts
      ) |> safe_to_string()

      assert form_input == ~s(<div class="form-group"><label class="control-label" for="name">Name</label><input class="form-control" id="name" name="name" type="text"></div>)
    end
  end
end
