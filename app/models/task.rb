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

  def logs_graph
    data = [[0,0]]
    i = 0
    return data if logs.empty?
    reset_time = logs.first.created_at.to_date + user.time_offset.hours

    logs.each do |log|
      reset_time ||= log.created_at.to_date + user.time_offset.hours

      while reset_time < log.created_at
        i += 1
        data << [i,0]
        reset_time += 1.day
      end

      data.last[1] += 1
    end


    # fill in zeros until today
    while reset_time < Time.now.utc
      i += 1
      data << [i, 0]
      reset_time += 1.day
    end

    data.each do |pt|
      pt[0] = pt[0] - i
    end

    return data
  end

  def values_graph(span=14)
    data = []
    i = 0
    return data if logs.with_value.empty?

    if Date.today - logs.with_value.first.created_at.to_date > span
      reset_time = Date.today - span.days + user.time_offset.hours
    else
      reset_time = logs.with_value.first.created_at.to_date + user.time_offset.hours
    end

    logs.with_value.each do |log|
      next if Date.today - log.created_at.to_date > span
      reset_time ||= log.created_at.to_date + user.time_offset.hours

      while reset_time < log.created_at
        i += 1
        data << [i,0]
        reset_time += 1.day
      end

      if log.value
        data.last[1] = log.value.to_i
      end

    end



    data.each do |pt|
      pt[0] = pt[0] - i
    end

    return data
  end

end
