module ApplicationHelper
  def error_messages( record )
    render :partial => "/layouts/error_messages", :locals => { :record => record }
  end
end
