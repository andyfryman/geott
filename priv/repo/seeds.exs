# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Geott.Repo.insert!(%Geott.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# drivers
Enum.each(1..10, fn(x) ->
  {:ok, _} = Geott.Users.create_driver(%{
    email: "driver#{x}@com.com",
    password: "12345678",
    password_confirmation: "12345678",
  })
end)

# managers
Enum.each(1..10, fn(x) ->
  {:ok, _} = Geott.Users.create_manager(%{
    email: "manager#{x}@com.com",
    password: "12345678",
    password_confirmation: "12345678",
  })
end)

# tasks
Enum.each(1..10, fn(_) ->
  {:ok, _} = Geott.Tasks.create_task(%{
    pickup: [Enum.random(-90..90), Enum.random(-90..90)],
    delivery: [Enum.random(-90..90), Enum.random(-90..90)],
  })
end)
