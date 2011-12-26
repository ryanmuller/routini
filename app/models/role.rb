class Role < ActiveRecord::Base
  belongs_to :user
  has_many :points, :dependent => :destroy
  has_many :task_roles, :dependent => :destroy
  has_many :tasks, :through => :task_roles
end
