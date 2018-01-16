alias Messaging.{Repo, Models}

Repo.delete_all(Models.User)
Repo.delete_all(Models.Thread)
Repo.delete_all(Models.Message)

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

user_one = Repo.insert!(%Models.User{
  email: "benaffleck@email.com",
  firstname: "ben",
  lastname: "affleck",
  role: "user"
})

user_two = Repo.insert!(%Models.User{
  email: "jack@jackmarchant.com",
  firstname: "jack",
  lastname: "marchant",
  role: "admin"
})

thread = Repo.insert!(%Models.Thread{
  name: "My Awesome Thread",
})

Repo.insert!(%Models.Message{
  thread: thread,
  sender: user_two,
  content: "Hey, this is a message on a thread."
})

Repo.insert!(%Models.Message{
  thread: thread,
  sender: user_one,
  content: "Hey, this is a message on a thread."
})
