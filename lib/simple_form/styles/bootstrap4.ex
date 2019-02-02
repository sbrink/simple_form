defmodule SimpleForm.Styles.Bootstrap4 do
  @behaviour SimpleForm.FormInputStyle
  alias Phoenix.HTML
  alias Phoenix.HTML.Form
  alias Phoenix.HTML.Tag

  alias SimpleForm.FormInput

  def checkbox(%FormInput{form: form, field: field, input_attrs: input_attrs, style_module: style_module} = form_input) do
    Tag.content_tag :div, class: "form-check" do
      [
        Form.checkbox(form, field, Keyword.merge([class: "form-check-input"], input_attrs)),
        style_module.label(form_input),
        style_module.hint(form_input),
        style_module.error_tag(form_input)
      ]
    end
  end

  def date_select(%FormInput{form: form, field: field, input_attrs: input_attrs, style_module: style_module} = form_input) do
    style_module.wrapper form_input do
      Form.text_input(form, field, Keyword.merge([class: "form-control"], input_attrs))
    end
  end

  def datetime_select(%FormInput{form: form, field: field, input_attrs: input_attrs, style_module: style_module} = form_input) do
    style_module.wrapper form_input do
      Form.text_input(form, field, Keyword.merge([class: "form-control"], input_attrs))
    end
  end

  def number_input(%FormInput{form: form, field: field, input_attrs: input_attrs, style_module: style_module} = form_input) do
    style_module.wrapper form_input do
      Form.number_input(form, field, Keyword.merge([class: "form-control"], input_attrs))
    end
  end

  def text_input(%FormInput{form: form, field: field, input_attrs: input_attrs, style_module: style_module} = form_input) do
    style_module.wrapper form_input do
      Form.text_input(form, field, Keyword.merge([class: "form-control"], input_attrs))
    end
  end

  def email_input(%FormInput{form: form, field: field, input_attrs: input_attrs, style_module: style_module} = form_input) do
    style_module.wrapper form_input do
      Form.email_input(form, field, Keyword.merge([class: "form-control"], input_attrs))
    end
  end

  def textarea(%FormInput{form: form, field: field, input_attrs: input_attrs, style_module: style_module} = form_input) do
    style_module.wrapper form_input do
      Form.textarea(form, field, Keyword.merge([class: "form-control"], input_attrs))
    end
  end

  def plain(%FormInput{form: form, field: field, input_attrs: input_attrs, style_module: style_module} = form_input) do
    style_module.wrapper form_input do
      Form.text_input(form, field, Keyword.merge([class: "form-control-plaintext", readonly: true], input_attrs))
    end
  end

  def select(%FormInput{form: form, field: field, input_attrs: input_attrs, collection: collection, style_module: style_module} = form_input) do
    style_module.wrapper form_input do
      Form.select(
        form,
        field,
        collection,
        Keyword.merge([class: "form-control c-select"], input_attrs)
      )
    end
  end

  @doc """
  Renders an debug tag for a form input.

  iex> debug(%FormInput{}) |> safe_to_string()
  ~s(<pre>#{%FormInput{} |> inspect(pretty: true)}</pre>)

  """
  def debug(%FormInput{} = form_opts) do
    Tag.content_tag(:pre, inspect(form_opts, pretty: true))
  end

  # wrapper
  def wrapper(%FormInput{style_module: style_module} = form_input, do: block) do
    Tag.content_tag :div, class: "form-group" do
      [
        style_module.label(form_input),
        style_module.input_group(form_input, block),
        style_module.hint(form_input),
        style_module.error_tag(form_input)
      ]
    end
  end

  def input_group(%FormInput{style_module: _style_module, wrapper_attrs: wrapper_attrs} = _form_input, block) do
    prepend_text_block =
      if prepend_text = Keyword.get(wrapper_attrs, :prepend_text) do
        Tag.content_tag :div, class: "input-group-prepend" do
          Tag.content_tag(:span, prepend_text, class: "input-group-text")
        end
      else
        HTML.raw("")
      end

    append_text_block =
      if append_text = Keyword.get(wrapper_attrs, :append_text) do
        Tag.content_tag :div, class: "input-group-append" do
          Tag.content_tag(:span, append_text, class: "input-group-text")
        end
      else
        HTML.raw("")
      end

    if prepend_text || append_text do
      Tag.content_tag :div, class: "input-group" do
        [
          prepend_text_block,
          block,
          append_text_block
        ]
      end
    else
      block
    end
  end

  @doc """
  Renders an label tag for a form input.

  iex> label(%FormInput{label: false}) |> safe_to_string()
  ""

  iex> label(%FormInput{form: %Phoenix.HTML.Form{}, field: :name, label: "Name", label_attrs: [], required: true}) |> safe_to_string()
  ~s(<label class="control-label required" for="name">Name</label>)

  iex> label(%FormInput{form: %Phoenix.HTML.Form{}, field: :name, label: "Name", label_attrs: [class: "A", disabled: "true"], required: true}) |> safe_to_string()
  ~s(<label class="A" disabled="true" for="name">Name</label>)

  iex> label(%FormInput{form: %Phoenix.HTML.Form{}, field: :name, label: "Name", label_attrs: []}) |> safe_to_string()
  ~s(<label class="control-label" for="name">Name</label>)

  iex> label(%FormInput{form: %Phoenix.HTML.Form{}, field: :name, label: "Name", label_attrs: [class: "A", disabled: "true"]}) |> safe_to_string()
  ~s(<label class="A" disabled="true" for="name">Name</label>)

  """
  def label(%FormInput{label: false}), do: HTML.raw("")

  def label(%FormInput{form: form, field: field, label: label, label_attrs: label_attrs, required: true}) do
    Form.label(form, field, label, Keyword.merge([class: "control-label required"], label_attrs))
  end

  def label(%FormInput{form: form, field: field, label: label, label_attrs: label_attrs}) do
    Form.label(form, field, label, Keyword.merge([class: "control-label"], label_attrs))
  end

  @doc """
  Renders an hint tag for a form input.

  iex> hint(%FormInput{hint: nil}) |> safe_to_string()
  ""

  iex> hint(%FormInput{hint: "This is a hint"}) |> safe_to_string()
  ~s(<small class="text-muted">This is a hint</small>)

  """
  def hint(%FormInput{hint: nil}), do: HTML.raw("")

  def hint(%FormInput{hint: hint}) do
    Tag.content_tag(:small, hint, class: "text-muted")
  end

  @doc """
  Renders an error tag for a form input.

  iex> error_tag(%FormInput{errors_translated: []}) |> safe_to_string()
  ""

  iex> error_tag(%FormInput{errors_translated: ["Some Error"]}) |> safe_to_string()
  ~s(<span class="help-block text-danger">⚠ Some Error</span>)

  """
  def error_tag(%FormInput{errors_translated: []}), do: HTML.raw("")

  def error_tag(%FormInput{errors_translated: errors_translated}) do
    Tag.content_tag(:span, "⚠ #{errors_translated}", class: "help-block text-danger")
  end
end
