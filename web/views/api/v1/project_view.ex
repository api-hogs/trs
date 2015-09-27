defmodule Trs.Api.V1.ProjectsView do
  use Trs.Web, :view

  alias Trs.Api.V1.ProjectSerializer

  def render("index.json-api", %{projects: projects}) do
    projects
    |> ProjectSerializer.format
  end

  def render("show.json-api", %{project: project}) do
    project
    |> ProjectSerializer.format
  end

end
