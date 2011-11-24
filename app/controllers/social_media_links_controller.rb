class SocialMediaLinksController < ApplicationController
  before_filter :must_be_logged_in
  before_filter :get_author
  before_filter :get_social_media_link, :only => %w(edit update)
  
  def index
    @author.social_media_links
    @unused_social_media_links = []
    
    for src in Sorcery.config.social_media.sources.keys
      unless @author.social_media_links.detect{|l| src == l.source.to_sym }
        @unused_social_media_links << SocialMediaLink.new( source: src, author: @author )
      end
    end
  end
  
  def create
    
    @social_media_link = SocialMediaLink.new( params[:social_media_link] )
    
    respond_to do |format|
      if @social_media_link.save
        format.js
        format.html
      else
        format.js
        format.html
      end
    end
  end
  
  def edit
    
  end
  
  def update
    respond_to do |format|
      if @social_media_link.update_attributes( params[:social_media_link] )
        format.js
        format.html { redirect_to author_path( @social_media_link.author ) }
      else
        format.js
        format.html { render action: edit, id: @social_media_link }
      end
    end
  end
  
  protected
  def get_author
    @author = Author.find( params[:author_id] )
  end

  def get_social_media_link
    debugger 
    @social_media_link = SocialMediaLink.find( params[:id] )
  end
end