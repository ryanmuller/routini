class LogsController < ApplicationController

  def create

    @task = Task.find(params[:log][:task_id])
    redirect_to tasks_path if @task.user != current_user

    @log = Log.new(params[:log])
    @log.user = current_user

    @log.save

    if params[:next_task_id]
      redirect_to Task.find(params[:next_task_id])
    else
      redirect_to tasks_path
    end
  end
end
