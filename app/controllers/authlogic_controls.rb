module AuthlogicControls
  # runs this when module is included in the given base class
  def self.included( base )
    base.class_eval do
      base.filter_parameters :password, :password_confirmation if base.respond_to?(:filter_parameters)
      base.helper_method :current_author_session, :current_author if base.respond_to?(:helper_method)
    end
  end

  def current_author_session
    return @current_author_session if defined?(@current_author_session)
    @current_author_session = AuthorSession.find
  end

  def current_author
    return @current_author if defined?(@current_author)
    @current_author = current_author_session && current_author_session.author
  end
end