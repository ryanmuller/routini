class TasksController < ApplicationController

  def create 
    @task = Task.new(params[:task])
    @task.user = current_user

    if @task.save 
      redirect_to root_path, notice: 'Task added.'
    else
      render 'pages/index'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to root_path, notice: 'Removed task.'
  end

  def index
    tasks = Task.where(:user_id => current_user.id)

    redirect_to root_path if tasks.empty?
    @task = tasks[rand(tasks.count)]
  end
end
