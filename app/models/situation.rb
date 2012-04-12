class Situation < ActiveRecord::Base
  belongs_to :user
  has_many :task_contexts, :dependent => :destroy
  has_many :tasks, :through => :task_contexts

  def points

    data = []
    day = Date.today - 5.days

    (0..6).each do |i|
      points = 0
      tasks.each do |task|
        points += task.logs.from_day(day, user.time_offset.hours).count
      end
      data << points
      day += 1.day
    end

    return data
  end

  def as_json(options={})
    super.merge({
      :tasks => self.tasks,
      :points => self.points
    })
  end
end
