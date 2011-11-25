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
  
  def social_media_source_to_name( src )
    src = src.source.to_sym if src.is_a?(SocialMediaLink)
    Sorcery.config.social_media.sources[ src ].name
  end
end
