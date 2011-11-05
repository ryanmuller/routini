class PagesController < ApplicationController
  
  def index
    @task = Task.new
    @tasks = Task.find_by_user_id(current_user)
    #@roles = Role.find_by_user_id
  end
end
