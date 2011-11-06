class Task < ActiveRecord::Base
  belongs_to :user
  has_many :logs
  has_many :points
  has_many :task_roles
  has_many :roles, :through => :task_roles

  accepts_nested_attributes_for :task_roles

  validates :name, :presence => true
end
