class PointsController < ApplicationController

  def destroy
    @point = Point.find(params[:id])
    @point.destroy

    redirect_to points_path, :notice => 'Removed point.'
  end


  def index
    @roles = current_user.roles

    @offset = params[:offset].nil? ? 0 : Integer(params[:offset])
    
    @points = current_user.points.from_time(Time.now - @offset.days, current_user)
    @rpdaily_json = []
    @roles.all.each_with_index do |role, i|
      @rpdaily_json << { :label => role.name, :data => [[i, @points.where("role_id = ?", role.id).sum('points')]] , :bars => { :show => :true } }
    end
    @rpdaily_json = @rpdaily_json.reverse.to_json.gsub(/"label"/, "label").gsub(/"data"/, "data").gsub(/"bars"/, "bars") 

    @rp_json = Point.plot_data_stacked(current_user, @roles).to_json.gsub(/"label"/, "label").gsub(/"data"/, "data") 

  end

end
