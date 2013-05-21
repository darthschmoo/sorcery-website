require 'fileutils'

module BookCoverImageSupport
  COVER_FOLDER = Rails.root.join( "public", "assets", "covers" )
  COVER_PATH   = "/".fwf_filepath.join( "assets", "covers" )    # probably shouldn't be in the model.
  
  def cover_image=( file )
    if file.is_a?(String)
      return super( file )
    else
      hash = Digest::MD5.hexdigest( file.tempfile.read )
      name = hash + File.extname( file.original_filename )
      dest = COVER_FOLDER.join( name )
    
      FileUtils.mv( file.tempfile.to_path, dest ) 
      FileUtils.chmod( 0644, dest )
    
      path = COVER_PATH.join( name )
      super path
    end
  end  
end