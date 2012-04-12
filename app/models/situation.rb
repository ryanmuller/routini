class Situation < ActiveRecord::Base
  belongs_to :user
  has_many :task_contexts, :dependent => :destroy
  has_many :tasks, :through => :task_contexts

  def points
    points = 0
    tasks.each do |task|
      points += task.logs.today(user.time_offset.hours).count
    end
    return points
  end

  def as_json(options={})
    super.merge({
      :points => self.points
    })
  end
end
