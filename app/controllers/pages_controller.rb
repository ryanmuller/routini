class PagesController < ApplicationController
  
  before_filter :must_log_in
  
  def index

    @tasks = Task.where("user_id = ?", current_user.id)
    @task = Task.new
    task_role = @task.task_roles.build
    @roles = Role.where("user_id = ?", current_user.id)

    @role_options = []
    @roles.each do |role|
      @role_options << [role.name, role.id]
    end
    @role = Role.new
    @points = Point.where("user_id = ?", current_user.id)

    @role_points = []
    @rp_xmax = @roles.length
    @rp_json = "["
    @rp_ticks = "["

    @roles.each_with_index do |role, i|
      points = Point.where("role_id = ? AND user_id = ?", 
                           role.id, current_user.id).sum("points")

      @role_points << [role.name, points]
      @rp_json += ", " unless @rp_json == "["
      @rp_ticks += ", " unless @rp_ticks == "["
      @rp_json += "[#{i},#{points}]"
      @rp_ticks += "[#{i},\"#{role.name}\"]"
      #@rp_json += "{ label: \"#{role.name}\", data: [[#{i},#{points}]] }"
    end
    @rp_json += "]"
    @rp_ticks += "]"
  end

  def must_log_in
    redirect_to new_user_session_path unless user_signed_in?
  end

end
