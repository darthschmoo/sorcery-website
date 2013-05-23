require 'bogus_request'

class Story < ActiveRecord::Base
  belongs_to :author, dependent: :destroy
  scope :published, where( "visibility = 'public'")
  scope :unpublished, where( "visibility != 'public'")
  scope :recent, lambda { |num_days = 30| where("created_at > ?", num_days.days.ago ) }
  
  after_save :delete_file_cache
  after_save :generate_file_cache, :if => Proc.new{|story| story.published? }
  
  def self.supported_formats
    formats = []
    
    for format, config in Sorcery.config.story.formats
      if config.status == "enabled"
        formats << format.to_s
      end
    end
    
    formats
  end
  
  SUPPORTED_FORMATS = self.supported_formats
    
  def published=( visibility )
    self.visibility = visibility ? "public" : "owner"
  end
  
  def published
    self.visibility == "public"
  end
  
  alias :published? :published
  
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
    Sorcery.config.story.filepath.fwf_filepath
  end
  
  def filename_and_path( format )
    stories_directory.join( filename( format ) )
  end
  
  def filename_and_absolute_path( format )
    Rails.root.join( filename_and_path( format ) )
  end
  
  def url_for( format )
    "/".fwf_filepath.join( stories_directory.gsub("public/",""), filename( format ) ).to_s
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
