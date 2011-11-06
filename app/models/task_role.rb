class TaskRole < ActiveRecord::Base
  belongs_to :task
  belongs_to :role
end
