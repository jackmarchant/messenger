alias Messaging.{Repo, Models}

Repo.delete_all(Models.User)

Repo.insert!(%Models.User{
  email: "joeblogs@email.com",
  firstname: "joe",
  lastname: "blogs",
  role: "user"
})

Repo.insert!(%Models.User{
  email: "mattdamon@email.com",
  firstname: "matt",
  lastname: "damon",
  role: "user"
})

Repo.insert!(%Models.User{
  email: "benaffleck@email.com",
  firstname: "ben",
  lastname: "affleck",
  role: "user"
})

Repo.insert!(%Models.User{
  email: "jack@jackmarchant.com",
  firstname: "jack",
  lastname: "marchant",
  role: "admin"
})
