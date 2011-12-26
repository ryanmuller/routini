class Situation < ActiveRecord::Base
  belongs_to :user
  has_many :task_contexts, :dependent => :destroy
  has_many :tasks, :through => :task_contexts
end
