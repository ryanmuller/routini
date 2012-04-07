class TasksController < ApplicationController
  respond_to :json, :html

  def create # from situations 
    @situation = current_user.situations.find(params[:situation_id])
    @task = Task.new(params[:task])
    @task.user = current_user
    @task.situations << @situation
    @task.save 

    respond_with @task, :location => root_url
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to root_path, :notice => 'Removed task.'
  end

  def index
    @tasks = current_user.tasks.includes(:task_contexts => :situation)
    @contexts = current_user.situations
    @context = current_user.situations.first
  end

  def show
    @task = Task.find(params[:id])
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
