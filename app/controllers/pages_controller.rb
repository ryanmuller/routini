class PagesController < ApplicationController
  
  before_filter :must_log_in
  
  def help
  end

  def must_log_in
    redirect_to new_user_session_path unless user_signed_in?
  end

end
