class MicrotasksController < ApplicationController

  respond_to :json

  def index
    @task = current_user.tasks.find(params[:task_id])
    respond_with @task.microtasks
  end

  def create
    @task = current_user.tasks.find(params[:task_id])
    @microtask = @task.microtasks.build(params[:microtask])
    @microtask.save
    respond_with @microtask, :location => root_url
  end

  def update
    @task = current_user.tasks.find(params[:task_id])
    @microtask = @task.microtasks.find(params[:id])
    @microtask.update_attributes(params[:microtask])
    respond_with @microtask, :location => root_url
  end
  
end
