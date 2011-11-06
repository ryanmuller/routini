class RolesController < ApplicationController
  def create
    @role = Role.new(params[:role])
    @role.user = current_user

    if @role.save
      redirect_to root_path, notice: 'Role added.'
    else
      render 'pages/index'
    end
  end

  def destroy
    @role = Role.find(params[:id])
    @role.destroy

    redirect_to root_path, notice: 'Removed role.'
  end

end
