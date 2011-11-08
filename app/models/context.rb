class Context < ActiveRecord::Base
  belongs_to :user
  has_many :task_contexts
  has_many :tasks, :through => :task_contexts
end
