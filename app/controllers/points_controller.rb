class PointsController < ApplicationController

  def destroy
    @point = Point.find(params[:id])
    @point.destroy

    redirect_to points_path, :notice => 'Removed point.'
  end


  def index
    @roles = current_user.roles

    @offset = params[:offset].nil? ? 0 : Integer(params[:offset])
    
    @points = current_user.points.from_time(Time.now - @offset.days, current_user)
    @rp_json = []
    @roles.all.each_with_index do |role, i|
      @rp_json << { :label => role.name, :data => [[i, @points.where("role_id = ?", role.id).count]] , :bars => { :show => :true } }
    end
    @rp_json = @rp_json.reverse.to_json.gsub(/"label"/, "label").gsub(/"data"/, "data").gsub(/"bars"/, "bars") 

  end

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

    if params[:next_task_id]
      redirect_to Task.find(params[:next_task_id])
    else
      redirect_to tasks_path, :notice => msg
    end
  end
end
