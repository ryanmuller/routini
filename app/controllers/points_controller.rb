class PointsController < ApplicationController

  def create 
    @task = Task.find_by_id(params[:point][:task_id])

    redirect_to tasks_path if @task.user != current_user

    task_roles = TaskRole.where("task_id = ?", @task.id)

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

    asdfadsf.each do wqer3

    redirect_to tasks_path, :notice => msg
  end
end
