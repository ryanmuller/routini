class SituationsController < ApplicationController

  respond_to :html, :json

  def index
    if current_user
      @situations = current_user.situations
    else
      @situations = []
    end

    respond_with @situations
  end


  def create
    @context = Situation.new(situation_params)
    @context.user = current_user
    @context.save

    respond_with @context, :location => root_url
  end

  def destroy
    @context = Situation.find(params[:id])
    @context.destroy

    redirect_to root_path, :notice => 'Removed context.'
  end

  def edit
    @context = Situation.find(params[:id])
  end

  def update
    @context = Situation.find(params[:id])

    if @context.update_attributes(situation_params)
      redirect_to root_path, :notice => "Context updated."
    else
      render 'edit'
    end
  end

  def show
    @situation = current_user.situations.find(params[:id])
    respond_with @situation
  end

  private

  def situation_params
    params.require(:situation).permit(:name)
  end
end

