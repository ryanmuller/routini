class PointsController < ApplicationController

  def create 
    @point = Point.new(params[:point])
    @point.user = current_user

    @point.save
    redirect_to tasks_path
  end
end
