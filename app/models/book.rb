require 'fileutils'

module BookCoverImageSupport
  COVER_FOLDER = File.join( Rails.root, "public", "assets", "covers" )
  COVER_PATH   = File.join( "/assets", "covers" )    # probably shouldn't be in the model.
  
  def image=( file )
    if file.is_a?(String)
      return super( file )
    else
      hash = Digest::MD5.hexdigest( file.tempfile.read )
      name = hash + File.extname( file.original_filename )
      dest = File.join( COVER_FOLDER, name )
    
      puts file.tempfile.to_path
      puts dest
    
      FileUtils.mv( file.tempfile.to_path, dest ) 
    
      path = File.join( COVER_PATH, name )
      super path
    end
  end  
end

class Book < ActiveRecord::Base
  include BookCoverImageSupport
  
  def author
    Author.find(1) # stub
  end
end
