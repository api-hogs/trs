defmodule Trs.Api.V1.ProjectSerializer do
  use JaSerializer
  alias Trs.User
  alias Trs.Project

  has_one(:user, field: :user_id, type: "users")
  attributes([ :url | Project.__schema__(:fields)])

end
