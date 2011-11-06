class LogsController < ApplicationController

  def create
    @log = Log.new(params[:log])
    @log.user = current_user

    @log.save
  end
end
