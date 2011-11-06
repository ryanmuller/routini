class Point < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  belongs_to :task
end
