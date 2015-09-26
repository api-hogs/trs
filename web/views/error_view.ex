defmodule Trs.ErrorView do
  use Trs.Web, :view

  def render("400.json-api", _assigns) do
    %{error: %{message: "Bad Request"}}
  end

  def render("401.json-api", _assigns) do
    %{error: %{message: "Unauthorized"}}
  end

  def render("403.json-api", _assigns) do
    %{error: %{message: "Forbidden"}}
  end

  def render("404.json-api", _assigns) do
    %{error: %{message: "Page not found"}}
  end

  def render("500.json-api", _assigns) do
    %{error: %{message: "Server internal error"}}
  end

  def render("422.json-api", _assigns) do
    %{error: %{message: "Unprocessable entity"}}
  end

  def render(_, _assigns) do
    %{error: %{message: "Server internal error"}}
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  # def template_not_found(_template, assigns) do
  #   render "500.html", assigns
  # end
end
