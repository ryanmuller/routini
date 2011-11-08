class TasksController < ApplicationController

  def create 
    @task = Task.new(params[:task])
    @task.user = current_user

    if @task.save 
      redirect_to root_path, :notice => 'Task added.'
    else
      render 'pages/index'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to root_path, :notice => 'Removed task.'
  end

  def index
    if params[:context]
      context = current_user.contexts.find(params[:context])
      tasks = context.tasks
    else 
      tasks = current_user.tasks
    end

    if tasks.empty?
      redirect_to root_path
    else
      @task = tasks[rand(tasks.count)]

      if params[:context]
        redirect_to task_path(@task, { :context => context })
      else 
        redirect_to task_path(@task)
      end
    end
  end

  def show
    @task = Task.find(params[:id])
    @point = Point.new
  end

  def edit
    @task = Task.find(params[:id])

    @task.task_roles.build if @task.task_roles == []

    current_user.contexts.each do |context|
      unless tc = @task.task_contexts.find_by_context_id(context.id)
        @task.task_contexts.build(:context_id => context.id)
      end
    end
  end

  def update
    @task = Task.find(params[:id])

    if @task.update_attributes(params[:task])
      redirect_to task_path(@task)
    else
      render 'edit'
    end
  end
end
