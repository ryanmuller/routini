class LogsController < ApplicationController

  respond_to :html, :json

  def create
    @task = current_user.tasks.find(params[:task_id])
    @log = @task.logs.build(params[:log])
    @log.user = current_user
    @log.save

    respond_with @log, :location => root_url
  end
end
