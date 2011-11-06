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
  end

  def must_log_in
    redirect_to new_user_session_path unless user_signed_in?
  end

end
