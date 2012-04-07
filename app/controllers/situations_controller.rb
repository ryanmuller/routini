class SituationsController < ApplicationController

  respond_to :html, :json

  def index
    @situations = current_user.situations
    respond_with @situations
  end


  def create
    @context = Situation.new(params[:situation])
    @context.user = current_user

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

    if @context.update_attributes(params[:situation])
      redirect_to root_path, :notice => "Context updated."
    else
      render 'edit'
    end
  end

  def show 
    @situation = Situation.find(params[:id])

    respond_to do |format|
      format.html
      format.josn { render :json => @situation }
    end
  end
end

