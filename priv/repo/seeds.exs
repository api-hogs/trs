# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Trs.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Trs.Repo
alias Trs.User
alias Trs.Project

alias PhoenixTokenAuth.Util

defmodule SeedUser do
  @email "user@example.com"
  @password "12345678"
  @confirmation_token "12345678"
  @hashed_password Util.crypto_provider.hashpwsalt(@password)
  @hashed_confirmation_token Util.crypto_provider.hashpwsalt(@confirmation_token)
  @authentication_tokens ["eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl9pZCI6Ing3Y2t3anE0VHduMVRtSmJNRmZ2R0JITFJPV3pQOEZoIiwiaWQiOjksImV4cCI6MTQ1MzI5NzI2Nn0.-2RHlK1CIYBLUC1zDOvTOv00GE1yxX0pXON5mZkRL-0"]

  def truncate do
    Repo.delete_all(User)
  end

  def populate do
    %User{email: @email, hashed_password: @hashed_password, confirmed_at: Ecto.DateTime.utc, hashed_confirmation_token: @hashed_confirmation_token, authentication_tokens: @authentication_tokens}
    |> Repo.insert!
  end
end

defmodule SeedProject do
  @title "Example project"
  @couchdb_name Trs.Utils.snake_case_title(@title)
  @description "Example project"

  def truncate do
    Repo.delete_all(Project)
    truncate_couch
  end

  def populate() do
    users = Repo.all(User)
    Enum.each users, fn(user) ->
      %Project{title: @title, description: @description, user_id: user.id, couchdb_name: @couchdb_name}
      |> Repo.insert!
    end
    populate_couch
  end

  def truncate_couch do
    Trs.Couchdb.Http.request(:delete, @couchdb_name)
  end

  def populate_couch do
    Trs.Couchdb.Http.request(:put, @couchdb_name)
  end
end

SeedProject.truncate
SeedUser.truncate
SeedUser.populate
SeedProject.populate
