class Role < ActiveRecord::Base
  belongs_to :user
  has_many :points
  has_many :task_roles 
  has_many :tasks, :through => :task_roles
end
