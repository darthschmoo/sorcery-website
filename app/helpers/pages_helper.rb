module PagesHelper
  def page_chunk name
    chunk = Page.find_by_slug( name )
    
    if chunk
      render partial: "/pages/chunk", object: chunk
    else
      if logged_in?
        render partial: "/pages/create_chunk", locals: { slug: name }
      else
        render partial: "/pages/empty_chunk"
      end
    end
  end
end
