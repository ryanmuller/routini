class Task < ActiveRecord::Base
  belongs_to :user
  has_many :logs
  has_many :points
  has_many :task_roles
  has_many :roles, :through => :task_roles
  has_many :task_contexts
  has_many :contexts, :through => :task_contexts

  accepts_nested_attributes_for :task_roles, :task_contexts

  validates :name, :presence => true
end
