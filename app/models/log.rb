class Log < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  default_scope :order => 'created_at ASC'
  scope :today, lambda { |offset| where("created_at > ?", Time.now.utc - offset) }
  scope :with_value, where("value IS NOT NULL")

  def self.plot_data(user, task)
    data = [[0,0]]
    i = 0
    return data if user.logs.empty?
    reset_time = user.logs.first.created_at.to_date + user.time_offset.hours

    task.logs.each do |log|
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
end
