FactoryGirl.define do
  factory :user do
    name                  "Test User"
    email                 "foo@example.com"
    password              "foobar"
    password_confirmation "foobar"
  end
end

FactoryGirl.define do
  factory :task do
    name     "Task"
  end
end

