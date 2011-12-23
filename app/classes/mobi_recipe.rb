class MobiRecipe < FormatRecipe
  format_name "mobi"
  
  precondition("ebook-convert not available.  Install Calibre ebook reader?") do |recipe|
    recipe.shell_command_exists?( "ebook-convert" )
  end

  precondition("epub source file does not exist") do |recipe|
    recipe.format_exists?(:epub)
  end
  
  def cook
    puts `ebook-convert #{@story.filename_and_absolute_path(:epub)} #{@story.filename_and_absolute_path(:mobi)} \
      --extra-css #{File.join( Rails.root, "app", "assets", "stylesheets", "epub.css")} \
      --remove-first-image`
    return $?.success?
  end
end