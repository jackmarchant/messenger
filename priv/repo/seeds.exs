alias Messaging.{Repo, User}

Repo.delete_all(User)

Repo.insert!(%User{
  email: "joeblogs@email.com",
  firstname: "joe",
  lastname: "blogs"
})

Repo.insert!(%User{
  email: "mattdamon@email.com",
  firstname: "matt",
  lastname: "damon"
})

Repo.insert!(%User{
  email: "benaffleck@email.com",
  firstname: "ben",
  lastname: "affleck"
})
