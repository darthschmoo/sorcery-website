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
  
  def last_updated( record )
    "<div class=\"time last_updated\">Last updated: #{ record.updated_at }</div>".html_safe
  end
  
  def markdown( text = "" )
    BlueCloth.new( text ).to_html.html_safe
  end

  def html_id( record )
    "#{record.class.name.tableize.singularize}_#{ record.id }"
  end
  
  def debugging_info
    out << "\n"
    out << "logger: #{Rails.logger.inspect}\n"
    out << "Rails.version: #{Rails.version}"
    
    out << "Gems -----"
    for g in Gem.loaded_specs.keys.sort
      out << "     #{g} => #{Gem.loaded_specs[g].inspect}\n"
    end
    
    out.html_safe
  end
end

ApplicationHelper.extend ApplicationHelper
