class ApplicationController < ActionController::Base
  protect_from_forgery

  def must_be_logged_in
    unless session[:logged_in]
      flash[:error] = "You can't do that."
      redirect_to "/" and return false
    end
  end
end
