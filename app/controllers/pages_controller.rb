class PagesController < ApplicationController
  
  
  def index
    if not user_signed_in?
      redirect_to new_user_session_path
    end

    @tasks = Task.where("user_id = ?", current_user.id)
    @task = Task.new
    #@roles = Role.find_by_user_id
  end
end
