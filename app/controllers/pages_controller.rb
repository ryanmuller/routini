class PagesController < ApplicationController
  
  before_filter :must_log_in
  
  def index

    @tasks = current_user.tasks.includes(:task_contexts => :context, :task_roles => :role)
    @contexts = current_user.contexts
    @roles = current_user.roles

    @task = Task.new
    task_role = @task.task_roles.build

    @contexts.each do |context|
      @task.task_contexts.build(:context_id => context.id)
    end

    @role_options = []
    @roles.each do |role|
      @role_options << [role.name, role.id]
    end
    @role = Role.new
    @points = current_user.points.includes(:role, :task, :user).from_day(Time.now.to_date)

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
    end
    @rp_json += "]"
    @rp_ticks += "]"

    @rp_json = Point.plot_data_stacked(current_user, @roles).to_json.gsub(/"label"/, "label").gsub(/"data"/, "data") 

    @context = Context.new
  end

  def must_log_in
    redirect_to new_user_session_path unless user_signed_in?
  end

end
