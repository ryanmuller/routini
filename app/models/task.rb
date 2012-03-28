class Task < ActiveRecord::Base
  belongs_to :user
  has_many :logs
  has_many :points
  has_many :task_roles, :dependent => :destroy
  has_many :roles, :through => :task_roles
  has_many :task_contexts, :dependent => :destroy
  has_many :contexts, :through => :task_contexts
  has_many :microtasks, :dependent => :destroy

  accepts_nested_attributes_for :task_roles, :reject_if => proc { |attributes| attributes['role_id'].blank? }
  accepts_nested_attributes_for :task_contexts, :allow_destroy => true

  validates :name, :presence => true

  default_scope :order => 'created_at ASC'

  def done_today
    logs.today(user.time_offset.hours).count
  end


end
