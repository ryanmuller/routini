class TasksController < ApplicationController
  respond_to :json, :html

  def create
    @situation = current_user.situations.find(params[:situation_id])
    @task = @situation.tasks.build(task_params)
    @task.save

    respond_with @task, :location => root_url
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to root_path, :notice => 'Removed task.'
  end

  def index
    if current_user
      @tasks = current_user.tasks.includes(:task_contexts => :situation)
      @contexts = current_user.situations
      @context = current_user.situations.first
    else
      @tasks = []
      @contexts = []
      @context = []
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])

    current_user.situations.each do |context|
      unless @task.task_contexts.find_by_situation_id(context.id)
        @task.task_contexts.build(:situation_id => context.id)
      end
    end

  end

  def update
    @task = current_user.tasks.find(params[:id])
    @task.update_attributes(params[:task])
    respond_with @task
  end

  private

  def task_params
    params.
      require(:task).
      permit(:name, :description, :display_type, :time).
      merge(:user => current_user)
  end
end
