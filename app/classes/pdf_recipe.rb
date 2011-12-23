class PdfRecipe < FormatRecipe
  format_name "pdf"
  
  precondition("html source file doesn't exist") do |recipe|
    recipe.format_exists?(:html)
  end
  
  precondition("no pdf converter available.  wkhtmltopdf recommended.  htmldoc as fallback.") do |recipe|
    recipe.shell_command_exists?( "wkhtmltopdf" ) || recipe.shell_command_exists?( "htmldoc" )
  end
  
  # Highly recommend installing wkhtmltopdf (the static version for your server's architecture/OS)
  # http://code.google.com/p/wkhtmltopdf/
  def cook
    if shell_command_exists?("wkhtmltopdf")
      `wkhtmltopdf #{@story.filename_and_absolute_path(:html)} #{@story.filename_and_absolute_path(:pdf)}`
    else
      `htmldoc -t pdf --fontspacing 1.2 --fontsize 17pt --no-title --no-toc -f #{@story.filename_and_absolute_path(:pdf)} #{@story.filename_and_absolute_path(:html)}`
    end
    $?.success?
  end
end