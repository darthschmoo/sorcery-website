class FormatRecipe
  attr_accessor :story
  
  def initialize( story )
    @story = story
  end

  # each block must be evaluated to true before
  # cooking will begin.  
  def self.precondition( msg = "Precondition not met", &block )
    @precondition_list ||= []
    @precondition_list << [msg, block]
  end
  
  def self.precondition_list
    @precondition_list || []
  end
  
  def self.format_name( f = nil )
    @format_name ||= f
    @format_name
  end
  
  precondition "No story given" do |recipe|
    !recipe.story.nil?
  end
  
  precondition "Cannot write to requested story file" do |recipe|
    recipe.format_writable?(recipe.class.format_name)
  end
  
  precondition "Format not supported" do |recipe|
    Story::SUPPORTED_FORMATS.include?(recipe.class.format_name)
  end
  
  precondition "Directory not writable: #{Story.stories_directory}" do |recipe|
    File.writable? Story.stories_directory
  end

  def self.cook( story )
    puts "Cooking #{self.format_name}"
    @recipe = self.new( story )
    if @recipe.preconditions_met?
      if @recipe.cook
        File.chmod( 0664, story.filename_and_absolute_path(@recipe.class.format_name) )
        true
      else
        false
      end
    else
      false
    end
  end

  def cook
    # do nothing. Actually creates the file in the desired ebook format.
    # return false if the ebook isn't created and placed into the filesystem.
    puts "Shouldn't be calling abstract."
    true
  end
  
  # overridden in inheriting classes.  Define to check for necessary prerequisites for
  # determining if the file can be created (including existence of source files, 
  # presence of shell commands, writability of destination directory, etc.)
  def preconditions_met?
    klass = self.class
    while true
      for msg, condition in klass.precondition_list
        unless condition.call(self)  # you can access the @story variable from inside preconditions.
          puts "Error creating #{self.class.format_name}: #{msg}"
          return false
        end 
      end
      
      return true if klass == FormatRecipe
      klass = klass.superclass
    end
  end
  
  def self.depends_on( classname )
    @dependencies ||= []
    @dependencies << classname
  end
  
  def format_exists?( format )
    File.exist?( @story.filename_and_absolute_path( format ) )
  end

  def shell_command_exists?( b )
    !(`which #{b}`.strip.empty?)
  end
  
  def format_writable?( format )
    file = @story.filename_and_absolute_path( format )
    return true if format_exists?( format ) && File.writable?( file )
    return true if !format_exists?( format ) && File.writable?( File.dirname( file ) ) 
    return false
  end
end
