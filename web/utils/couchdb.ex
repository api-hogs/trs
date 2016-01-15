defmodule Trs.Utils do
  def snake_case_title(title) do
    title
    |> String.downcase()
    |> String.replace(" ", "_")
  end
end
