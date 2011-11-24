module ApplicationHelper
  def error_messages( record )
    render :partial => "/layouts/error_messages", :locals => { :record => record }
  end
  
  def social_media_link_icon( link, opts = {} )
    if opts[:size] && opts[:size].to_sym == :large
      sz = :icon_lg
    else
      sz = :icon  
    end
    
    Sorcery.config.social_media.sources[ link.source.to_sym ][sz]
  end
end
