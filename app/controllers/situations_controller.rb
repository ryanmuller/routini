class SituationsController < ApplicationController

  def index
    @situations = current_user.situations
    respond_to do |format|
      format.html
      format.json { render :json => @situations }
    end
  end


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

