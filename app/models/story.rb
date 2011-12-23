require 'bogus_request'

class Story < ActiveRecord::Base
  belongs_to :author, dependent: :destroy
  scope :published, where( "published = TRUE")
  scope :unpublished, where( "published = FALSE")
  scope :recent, lambda { |num_days = 30| where("created_at > ?", num_days.days.ago ) }
  
  after_save :delete_file_cache
  after_save :generate_file_cache, :if => Proc.new{|story| story.published? }
  
  def self.supported_formats
    formats = []
    
    Sorcery.config.story.formats.keys.each do |format|
      if Sorcery.config.story.formats[format].status == "enabled"
        formats << format.to_s
      end
    end
    
    formats
  end
  
  SUPPORTED_FORMATS = self.supported_formats
    
  def word_count
    body ? body.length / 6 : 0
  end
  
  def filename_prefix
    "banned_sorcery.#{self.id}-#{self.title.parameterize("_")}"[0..50]
  end
  
  def filename( format )
    "#{filename_prefix}.#{format}"
  end
  
  def stories_directory
    self.class.stories_directory
  end
  
  def self.stories_directory
    Sorcery.config.story.filepath
  end
  
  def filename_and_path( format )
    File.join( stories_directory, filename( format ) )
  end
  
  def filename_and_absolute_path( format )
    File.join( Rails.root, filename_and_path( format ) )
  end
  
  def url_for( format )
    File.join( "/", stories_directory.gsub("public/",""), filename( format ) )
  end

  

  



  def delete_file_cache
    for format in SUPPORTED_FORMATS
      delete_story_file( format )
    end
    true
  end
  
  def generate_file_cache
    HtmlRecipe.cook( self )    # all other formats use this as a starting point
    MarkdownRecipe.cook( self ) 
    EpubRecipe.cook( self )
    PdfRecipe.cook( self )
    MobiRecipe.cook( self )  # uses .epub as source
  end
  
  def delete_story_file( format )
    f = filename_and_absolute_path( format )
    FileUtils.rm( f ) if File.exist?( f )
  end
end
