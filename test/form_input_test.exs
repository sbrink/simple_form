defmodule SimpleForm.FormInputTest do
  use ExUnit.Case
  import SimpleForm.FormInput

  doctest SimpleForm.FormInput

  describe "form_input" do
    test "takes a form and generates input opts" do
      input_opts =
        build(
          %Phoenix.HTML.Form{impl: Phoenix.HTML.FormData.Ecto.Changeset, source: %{types: %{name: :string}, required: [], validations: []}},
          :name,
          [],
          fn x -> x end,
          SimpleForm.Styles.Bootstrap4
        )

      assert input_opts == %SimpleForm.FormInput{
          clean_opts: [],
          collection: nil,
          errors: [],
          errors_translated: [],
          field: :name,
          field_str: "name",
          form: %Phoenix.HTML.Form{
            action: nil,
            data: nil,
            errors: [],
            hidden: [],
            id: nil,
            impl: Phoenix.HTML.FormData.Ecto.Changeset,
            index: nil,
            name: nil,
            options: [],
            params: %{},
            source: %{
              required: [],
              types: %{name: :string},
              validations: []
            }
          },
          hint: nil,
          input_attrs: [],
          label: "Name",
          label_attrs: [],
          label_human: "Name",
          label_translated: nil,
          opts: [],
          required: false,
          style_module: SimpleForm.Styles.Bootstrap4,
          wrapper_attrs: []
        }
    end

    test "detect required state from ecto schema." do
      input_opts_with_required =
        build(
          %Phoenix.HTML.Form{impl: Phoenix.HTML.FormData.Ecto.Changeset, source: %{types: %{name: :string}, required: [:name], validations: []}},
          :name,
          [],
          fn x -> x end,
          SimpleForm.Styles.Bootstrap4
        )

        input_opts_without_required =
          build(
            %Phoenix.HTML.Form{impl: Phoenix.HTML.FormData.Ecto.Changeset, source: %{types: %{name: :string}, required: [], validations: []}},
            :name,
            [],
            fn x -> x end,
            SimpleForm.Styles.Bootstrap4
          )

      assert input_opts_with_required.required == true
      assert input_opts_without_required.required == false
    end
  end
end
