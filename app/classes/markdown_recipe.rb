class MarkdownRecipe < FormatRecipe
  format_name "markdown"
  
  def cook
    File.open( @story.filename_and_absolute_path(:markdown), "w" ) do |f|
      f << "##{@story.title}#\n\n"
      f << "*by #{@story.author.name}*\n\n"
      f << @story.body
      f << "\n\n"
      f << "*****\n"
      f << "Copyright notice: #{Sorcery.config.copyright_notice}"
    end
    
    true
  end
end