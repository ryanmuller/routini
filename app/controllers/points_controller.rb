class PointsController < ApplicationController

  def create 
    @task = Task.find_by_id(params[:point][:task_id])
    task_roles = TaskRole.where("task_id = ? AND user_id = ?",
                                @task.id,
                                current_user.id)

    msg = "Earned"

    task_roles.each do |tr|
      point = Point.new(params[:point])
      point.user = current_user
      point.role = tr.role
      point.points = tr.points
      if point.save
        msg += " +#{tr.points} for #{tr.role}!"
      end
    end

    msg = "" if msg == "Earned"

    redirect_to tasks_path, :notice => msg
  end
end
