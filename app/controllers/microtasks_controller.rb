class MicrotasksController < ApplicationController

  respond_to :js

  def index
    @task = current_user.tasks.find(params[:task_id])
    respond_with(@microtasks = @task.microtasks, :status => :ok)
  end

  def create
    @task = current_user.tasks.find(params[:task_id])
    @microtask = @task.microtasks.build(params[:microtask])
    @microtask.save
    respond_with @microtask
  end

  def destroy
  end
  
end
