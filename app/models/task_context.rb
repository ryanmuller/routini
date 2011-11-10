class TaskContext < ActiveRecord::Base
  belongs_to :task
  belongs_to :situation
end
