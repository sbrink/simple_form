defmodule SimpleForm.Styles.Bootstrap4 do
  @behaviour SimpleForm.FormInputStyle
  alias Phoenix.HTML
  alias Phoenix.HTML.Form
  alias Phoenix.HTML.Tag

  alias SimpleForm.FormInput

  def checkbox(%FormInput{form: form, field: field, input_attrs: input_attrs, style_module: style_module} = form_input) do
    Tag.content_tag :div, class: "form-check" do
      [
        Form.checkbox(form, field, Keyword.merge(input_attrs, class: "form-check-input")),
        style_module.label(form_input),
        style_module.hint(form_input),
        style_module.error_tag(form_input)
      ]
    end
  end

  def date_select(%FormInput{form: form, field: field, input_attrs: input_attrs, style_module: style_module} = form_input) do
    style_module.wrapper form_input do
      [
        Form.text_input(form, field, Keyword.merge(input_attrs, class: "form-control"))
      ]
    end
  end

  def datetime_select(%FormInput{form: form, field: field, input_attrs: input_attrs, style_module: style_module} = form_input) do
    style_module.wrapper form_input do
      [
        Form.text_input(form, field, Keyword.merge(input_attrs, class: "form-control"))
      ]
    end
  end

  def number_input(%FormInput{form: form, field: field, input_attrs: input_attrs, style_module: style_module} = form_input) do
    style_module.wrapper form_input do
      [
        Form.number_input(form, field, Keyword.merge(input_attrs, class: "form-control"))
      ]
    end
  end

  def text_input(%FormInput{form: form, field: field, input_attrs: input_attrs, style_module: style_module} = form_input) do
    style_module.wrapper form_input do
      [
        Form.text_input(form, field, Keyword.merge(input_attrs, class: "form-control"))
      ]
    end
  end

  def email_input(%FormInput{form: form, field: field, input_attrs: input_attrs, style_module: style_module} = form_input) do
    style_module.wrapper form_input do
      [
        Form.email_input(form, field, Keyword.merge(input_attrs, class: "form-control"))
      ]
    end
  end

  def textarea(%FormInput{form: form, field: field, input_attrs: input_attrs, style_module: style_module} = form_input) do
    style_module.wrapper form_input do
      [
        Form.textarea(form, field, Keyword.merge(input_attrs, class: "form-control"))
      ]
    end
  end

  def select(%FormInput{form: form, field: field, input_attrs: input_attrs, collection: collection, style_module: style_module} = form_input) do
    style_module.wrapper form_input do
      Form.select(
        form,
        field,
        collection,
        Keyword.merge(input_attrs, class: "form-control c-select")
      )
    end
  end

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

  def label(%FormInput{label: false}), do: HTML.raw("")

  def label(%FormInput{form: form, field: field, label: label, label_attrs: label_attrs, required: true}) do
    Form.label(form, field, label, Keyword.merge(label_attrs, class: "control-label required"))
  end

  def label(%FormInput{form: form, field: field, label: label, label_attrs: label_attrs}) do
    Form.label(form, field, label, Keyword.merge(label_attrs, class: "control-label"))
  end

  def hint(%FormInput{hint: nil}), do: HTML.raw("")

  def hint(%FormInput{hint: hint}) do
    Tag.content_tag(:small, hint, class: "text-muted")
  end

  def error_tag(%FormInput{errors_translated: []}), do: HTML.raw("")

  def error_tag(%FormInput{errors_translated: errors_translated}) do
    Tag.content_tag(:span, "⚠ #{errors_translated}", class: "help-block text-danger")
  end
end
