class Log < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  before_save :create_points
  
  def create_points
    return if task.nil?
    task.task_roles.each do |tr|
      point = Point.new()
      point.task = task
      point.task_name = task.name
      point.user = user
      point.role = tr.role
      point.points = tr.points
      point.save
    end
  end

end
