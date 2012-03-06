class EpubRecipe < FormatRecipe
  format_name "epub"
  
  precondition("EeePub gem not installed or not active") do |recipe|
    defined?(EeePub)
  end

  precondition("html source file doesn't exist") do |recipe|
    recipe.format_exists?(:html)
  end
  
  def cook
    story = @story            # self changes inside the loop
    epub = EeePub.make do
      title       story.title
      creator     "Bryce Anderson"           # TODO: should be story.author, but haven't implemented it yet
      publisher   "bannedsorcery.com"
      date        (story.new_record? ? Time.now : story.updated_at).strftime("%Y-%m-%d")
      
      
      story_file = story.filename_and_absolute_path( :html )
      stylesheet = File.join( Rails.root, "app", "assets", "stylesheets", "epub.css")
      horizontal_break = File.join( Rails.root, "app", "assets", "images", "hr_swirl.png")
      
      
      # canonical URL for this story
      identifier  BogusRequest().story_url(story), scheme: "URI"
      files [ story_file,
              { stylesheet => "stylesheets" },
              { horizontal_break => "images" }
            ]
            
      nav [ { :label => story.title}
        
      ]
    end
    
    epub.save( story.filename_and_absolute_path(:epub) )
    true
  end
end