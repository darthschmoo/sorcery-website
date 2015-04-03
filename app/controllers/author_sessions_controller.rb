class AuthorSessionsController < ApplicationController
  before_filter :require_no_author_session, only: [:new, :create]
  # before_filter :require_author, only: :destroy
  # before_filter :require_author_session, only: :destroy
  
  def new
    @author_session = AuthorSession.new
  end
  
  def create
    @author_session = AuthorSession.new(params[:author_session])
    if @author_session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default "/"
    else
      render action: :new
    end
  end
  
  def destroy
    if current_author_session
      current_author_session.destroy
      flash[:notice] = "Logout successful!"
    else
      flash[:notice] = "You weren't logged in when you tried to log out."
    end
    
    redirect_back_or_default "/login"
  end
end
