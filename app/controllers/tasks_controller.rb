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
    if session[:context] and not params[:all]
      context = current_user.situations.find(session[:context])
      tasks = context.tasks
    else 
      session[:context] = nil
      tasks = current_user.tasks
    end

    if tasks.empty?
      redirect_to root_path, :error => 'No tasks to shuffle'
    else
      @task = tasks[rand(tasks.count)]

      redirect_to task_path(@task)
    end
  end

  def show
    @task = Task.find(params[:id])
    @log = Log.new
    @microtask = @task.microtasks.build
    @contexts = current_user.situations
    @log_json = Log.plot_data(current_user, @task).to_json
  end

  def edit
    @task = Task.find(params[:id])

    current_user.situations.each do |context|
      unless tc = @task.task_contexts.find_by_situation_id(context.id)
        @task.task_contexts.build(:situation_id => context.id)
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
