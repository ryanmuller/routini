class SituationsController < ApplicationController

  def create

    @context = Situation.new(params[:situation])
    @context.user = current_user

    if @context.save
      redirect_to root_path, :notice => 'Context added.'
    else
      render 'pages/index'
    end
  end

  def destroy
    @context = Situation.find(params[:id])
    @context.destroy

    redirect_to root_path, :notice => 'Removed context.'
  end

  def show 
    @context = Situation.find(params[:id])
    session[:context] = @context.id
    redirect_to tasks_path
  end
end

