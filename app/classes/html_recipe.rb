class HtmlRecipe < FormatRecipe
  format_name "html"
  
  def cook
    html = ApplicationController.new.render_to_string partial: "/stories/story_complete_simple_html", object: @story, format: "html", layout: false
    File.open( @story.filename_and_absolute_path( :html ), "w" ) do |fil|
      fil.write( html )
      fil.flush
    end
    true  
  end
end