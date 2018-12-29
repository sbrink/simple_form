defmodule SimpleForm.TypeDetector do
  @moduledoc """
  The TypeDetector tries to to detect
  the type (e.g. text_field, textarea, select)
  based on the type from the ecto model oder
  params passed to it.

  Examples:
  input(f, :descripton, rows: 10) # is likely a textarea
  input(f, :state, collection: [...]) # is likely a select box
  """

  def get_input_type(form, field, opts) do
    from_parameters(opts) || Phoenix.HTML.Form.input_type(form, field)
  end

  defp from_parameters(opts) do
    cond do
      opts[:rows] -> :textarea
      opts[:collection] -> :select
      true -> nil
    end
  end
end
