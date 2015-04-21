require 'fileutils'

module BookCoverImageSupport
  def cover_folder
    Sorcery.config.book_review.cover_folder
  end
  
  def cover_path
    Sorcery.config.book_review.cover_path
  end
  
  def cover_image=( file )
    if file.is_a?(String)
      return super( file )
    else
      hash = Digest::MD5.hexdigest( file.tempfile.read )
      name = hash + File.extname( file.original_filename )
      dest = cover_folder.join( name ).to_s
    
      FileUtils.mv( file.tempfile.to_path, dest ) 
      FileUtils.chmod( 0644, dest )
    
      path = cover_path + "/#{name}"
      super path
    end
  end  
end

