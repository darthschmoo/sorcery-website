require 'bogus_request'

class Story < ActiveRecord::Base
  scope :published, where( "published = TRUE")
  scope :unpublished, where( "published = FALSE")
  scope :recent, lambda { |num_days = 30| where("created_at > ?", num_days.days.ago ) }
  
  before_save :delete_file_cache
  before_save :generate_file_cache
  
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
  
  puts SUPPORTED_FORMATS
  
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

  
  # If the given story doesn't exist in the requested file format, build it.
  def generate_html_file
    html = ApplicationController.new.render_to_string partial: "/stories/story_complete_simple_html", object: self, format: "html", layout: false
    File.open( filename_and_absolute_path( :html ), "w" ) do |fil|
      fil.write( html )
      fil.flush
    end
  end
  
  def generate_pdf_file
    tempfile do |t|
      t.write `htmldoc --no-title --no-toc  #{filename_and_path(:html)}`  # for debugging purposes
      t.flush
      
      puts t.read
      
      `htmldoc -t pdf --fontspacing 1.2 --fontsize 17pt --no-title --no-toc -f #{filename_and_absolute_path(:pdf)} #{t.path}`
    end
  end

  def generate_mobi_file
    puts "No mobi!"
  end
  
  def generate_epub_file
    story = self
    epub = EeePub.make do
      title       story.title
      creator     "Bryce Anderson"           # TODO: should be story.author, but haven't implemented it yet
      publisher   "bannedsorcery.com"
      date        story.updated_at.strftime("%Y-%m-%d")
      
      # canonical URL for this story
      identifier  BogusRequest().story_url(story), scheme: "URI"
      files [ story.filename_and_absolute_path( :html ), 
             File.join( Rails.root, "app", "assets", "stylesheets", "epub.css"),
             File.join( Rails.root, "app", "assets", "images", "hr_swirl.png") ]
    end
    
    epub.save( story.filename_and_absolute_path(:epub) )
  end
  
  def delete_file_cache
    puts "deleting cache for #{self.id}"
    for format in SUPPORTED_FORMATS
      delete_story_file( format )
    end
    puts "done deleting -----------------------------"
    true
  end
  
  def generate_file_cache
    puts "generating cache for #{self.id}"
    generate_html_file    # all other formats use this as a starting point
    generate_pdf_file if SUPPORTED_FORMATS.include?( "pdf" )
    generate_mobi_file if SUPPORTED_FORMATS.include?( "mobi" )
    generate_epub_file if SUPPORTED_FORMATS.include?( "epub" )
    puts "done ------------------------------------------------"
  end
  
  def delete_story_file( format )
    f = filename_and_absolute_path( format )
    FileUtils.rm( f ) if File.exist?( f )
  end
  
  def author
    "Bryce Anderson"
  end
end
