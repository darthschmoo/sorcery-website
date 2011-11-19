class ApplicationController < ActionController::Base
  protect_from_forgery

  def must_be_logged_in
    unless logged_in?
      flash[:error] = "You can't do that."
      redirect_to "/" and return false
    end
  end
  
  def logged_in?( &block )
    if block_given? && session[:logged_in]
      yield
    else
      session[:logged_in]
    end
  end
  
  def abandon_action( msg = "You can't do that.", go = { :action => :index } )
    flash[:error] = msg
    redirect_to go
  end
  
  helper_method :logged_in?
end
