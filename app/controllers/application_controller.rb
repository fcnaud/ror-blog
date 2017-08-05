class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include Concerns::UserSession
  include ApplicationHelper

private
  def auth_user
    unless logged_in?
      flash[:notice] = "please login first"
      redirect_to new_session_path
    end
  end
end
