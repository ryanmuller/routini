class MicrotasksController < ApplicationController

  respond_to :html, :json

  def index
    @task = current_user.tasks.find(params[:task_id])
    respond_with(@microtasks = @task.microtasks, :status => :ok)
  end

  def create
    @task = current_user.tasks.find(params[:task_id])
    @microtask = @task.microtasks.build(params[:microtask])
    @microtask.save
    respond_with @microtask, :only => [ :name ]
  end

  def destroy
  end
  
end
