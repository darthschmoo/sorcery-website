class ApplicationController < ActionController::Base
  include AuthlogicControls
  include AuthlogicAccessMethods
  
  protect_from_forgery

  def must_be_logged_in
    unless logged_in?
      flash[:error] = "You can't do that."
      redirect_to "/" and return false
    end
  end
  
  def logged_in?( &block )
    if current_author_session
      yield if block_given?
      current_author_session
    else
      false
    end
  end
  
  def abandon_action( msg = "You can't do that.", go = { action: :index } )
    flash[:error] = msg
    redirect_to go
  end
  
  helper_method :logged_in?
  
  def reveal_block( title, &block )
    r = render :partial => "/layouts/reveal_block" do
      yield if block_given?
    end
    
    r.join("\n").html_safe
  end
  
  helper_method :reveal_block
end
