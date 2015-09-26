defmodule Trs.ErrorViewTest do
  use Trs.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.json-api" do
    {:ok, %{"error" => %{"message" => message}}} = render_to_string(Trs.ErrorView, "404.json-api", []) |> Poison.decode
    assert message = "Page not found"
  end

  test "render 500.json-api" do
    {:ok, %{"error" => %{"message" => message}}} = render_to_string(Trs.ErrorView, "500.json-api", []) |> Poison.decode
    assert message = "Server internal error"
  end

  test "render any other" do
    {:ok, %{"error" => %{"message" => message}}} = render_to_string(Trs.ErrorView, "505.json-api", []) |> Poison.decode
    assert message = "Server internal error"
  end
end
