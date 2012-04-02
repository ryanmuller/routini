class PagesController < ApplicationController
  
  before_filter :must_log_in
  
  def index

    @tasks = current_user.tasks.includes(:task_contexts => :situation, :task_roles => :role)
    @contexts = current_user.situations
    @context = current_user.situations.first

    @task = Task.new

    @contexts.each do |context|
      @task.task_contexts.build(:situation_id => context.id)
    end

  end

  def help
  end

  def must_log_in
    redirect_to new_user_session_path unless user_signed_in?
  end

end
