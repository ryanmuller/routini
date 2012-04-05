class Task < ActiveRecord::Base
  belongs_to :user
  has_many :logs
  has_many :task_contexts, :dependent => :destroy
  has_many :situations, :through => :task_contexts
  has_many :microtasks, :dependent => :destroy

  accepts_nested_attributes_for :task_contexts, :allow_destroy => true

  validates :name, :presence => true

  default_scope :order => 'created_at ASC'

  def as_json(options={})
    super.merge({ 
      :context_ids => self.situations.collect { |s| s.id },
      :value_pts => self.values_graph,
      :log_pts => self.logs_graph,
      :todos => self.microtasks.incomplete.collect { |m| m.name },
      :dones => self.microtasks.complete.created_today(self.user.time_offset.hours).collect { |m| m.name }
    })
  end

  def done_today
    logs.today(user.time_offset.hours).count
  end

  def logs_graph
    data = [0]
    i = 0
    return data if logs.empty?
    reset_time = logs.first.created_at.to_date + user.time_offset.hours

    logs.each do |log|
      reset_time ||= log.created_at.to_date + user.time_offset.hours

      while reset_time < log.created_at
        i += 1
        data << 0
        reset_time += 1.day
      end

      data[-1] += 1
    end


    # fill in zeros until today
    while reset_time < Time.now.utc
      i += 1
      data << 0
      reset_time += 1.day
    end

    return data
  end

  def values_graph(span=14)
    data = []
    return data if logs.with_value.empty?

    logs.with_value.each do |log|
      data << ["#{log.created_at.year}-#{log.created_at.month-1}-#{log.created_at.day}", log.value]
    end

    return data
  end

end
