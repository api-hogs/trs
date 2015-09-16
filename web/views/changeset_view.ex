defmodule Trs.ChangesetView do
  use Trs.Web, :view

  def render("error.json-api", %{changeset: changeset}) do
    # When encoded, the changeset returns its errors
    # as a JSON object. So we just pass it forward.
    %{errors: changeset}
  end
end
