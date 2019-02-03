defmodule SimpleForm.Factory do
  use ExMachina

  def form_input_factory do
    %SimpleForm.FormInput{
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

  def form_factory do
    %Phoenix.HTML.Form{
      impl: Phoenix.HTML.FormData.Ecto.Changeset,
      source: %{
        types: %{name: :string},
        required: [],
        validations: []
      }
    }
  end
end
