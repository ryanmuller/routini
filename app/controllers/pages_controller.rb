class PagesController < ApplicationController
  
  before_filter :must_log_in
  
  def index

    @tasks = current_user.tasks.includes(:task_contexts => :situation, :task_roles => :role)
    @contexts = current_user.situations
    @roles = current_user.roles

    @task = Task.new
    task_role = @task.task_roles.build

    @contexts.each do |context|
      @task.task_contexts.build(:situation_id => context.id)
    end

    @role = Role.new
    @points = current_user.points.includes(:role, :task, :user).from_time(Time.now.utc, current_user)

    @rp_json = Point.plot_data_stacked(current_user, @roles).to_json.gsub(/"label"/, "label").gsub(/"data"/, "data") 

    @rpdaily_json = []
    @roles.all.each_with_index do |role, i|
      @rpdaily_json << [role.name, current_user.points.from_time(Time.now.utc, current_user).where("role_id = ?", role.id).sum('points')]
    end
    @rpdaily_json = @rpdaily_json.reverse.to_json.gsub(/"label"/, "label").gsub(/"data"/, "data").gsub(/"bars"/, "bars") 

    @context = Situation.new
  end

  def help
  end

  def must_log_in
    redirect_to new_user_session_path unless user_signed_in?
  end

end
