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

  def truncate do
    Repo.delete_all(User)
  end

  def populate do
    %User{email: @email, hashed_password: @hashed_password, confirmed_at: Ecto.DateTime.utc, hashed_confirmation_token: @hashed_confirmation_token}
    |> Repo.insert!
  end

  def seed do
    truncate
    populate
  end
end

defmodule SeedProject do
  @title "Example project"
  @description "Example project"

  def truncate do
    Repo.delete_all(Project)
  end

  def populate() do
    users = Repo.all(User)
    Enum.each users, fn(user) ->
      %Project{title: @title, description: @description, user_id: user.id}
      |> Repo.insert!
    end
  end

  def seed do
    truncate
    populate
  end
end

SeedUser.seed
SeedProject.seed
