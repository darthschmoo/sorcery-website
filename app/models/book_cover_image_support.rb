require 'fileutils'

module BookCoverImageSupport
  COVER_FOLDER = File.join( Rails.root, "public", "assets", "covers" )
  COVER_PATH   = File.join( "/assets", "covers" )    # probably shouldn't be in the model.
  
  def cover_image=( file )
    if file.is_a?(String)
      return super( file )
    else
      hash = Digest::MD5.hexdigest( file.tempfile.read )
      name = hash + File.extname( file.original_filename )
      dest = File.join( COVER_FOLDER, name )
    
      FileUtils.mv( file.tempfile.to_path, dest ) 
      FileUtils.chmod( 0644, dest )
    
      path = File.join( COVER_PATH, name )
      super path
    end
  end  
end