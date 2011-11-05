Factory.define :user do |user|
  user.name                  "Test User"
  user.email                 "foo@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.define :task do |task|
  task.name     "Task"
end

