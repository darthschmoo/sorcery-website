module AuthlogicAccessMethods
  def current_author_session
    return @current_author_session if defined?(@current_author_session)
    @current_author_session = AuthorSession.find
  end
  
  def current_author
    return @current_author if defined?(@current_author)
    @current_author = current_author_session && current_author_session.record
  end
  
  def require_author
    unless current_author
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_author_session_url
      return false
    end
  end

  def require_no_author
    if current_author
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to author_url( current_author )
      return false
    end
  end
  
  def store_location
    session[:return_to] = request.env['REQUEST_URI']
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end