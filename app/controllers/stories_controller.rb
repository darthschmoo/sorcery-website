class StoriesController < ApplicationController
  before_filter :get_story, :only => %w(show edit update destroy)
  before_filter :must_be_logged_in, :only => %w(new edit create update destroy)
  before_filter :hide_unpublished_stories_from_ignorant_masses, :only =>  %w(show)
  # GET /stories
  # GET /stories.json
  def index
    @stories = logged_in? ? Story.all : Story.published

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stories }
    end
  end

  # GET /stories/1
  # GET /stories/1.json
  def show
    @story = Story.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @story }
      format.pdf  { return serve_format @story }
      format.epub { serve_format @story }
      format.mobi { serve_format @story }
    end
  end

  # GET /stories/new
  # GET /stories/new.json
  def new
    @story = Story.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @story }
    end
  end

  # GET /stories/1/edit
  def edit
    @story = Story.find(params[:id])
  end

  # POST /stories
  # POST /stories.json
  def create
    @story = Story.new(params[:story])

    respond_to do |format|
      if @story.save
        format.html { redirect_to @story, notice: 'Story was successfully created.' }
        format.json { render json: @story, status: :created, location: @story }
      else
        format.html { render action: "new" }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stories/1
  # PUT /stories/1.json
  def update
    @story = Story.find(params[:id])

    respond_to do |format|
      if @story.update_attributes(params[:story])
        format.html { redirect_to @story, notice: 'Story was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    @story = Story.find(params[:id])
    @story.destroy

    respond_to do |format|
      format.html { redirect_to stories_url }
      format.json { head :ok }
    end
  end
  
  protected
  def get_story
    @story = Story.find_by_id( params[:id] )
    if @story.nil?
      flash[:error] = "Could not find story with id #{params[:id]}"
      redirect_to :action => :index
      return false
    end
  end
  
  def hide_unpublished_stories_from_ignorant_masses
    unless @story.published? || logged_in?
      flash[:error] = "This story is not public."
      redirect_to :action => :index
      return false
    end
  end
  
  
  def serve_format( story, format = params[:format] )
    if format_enabled?( format )
      filename = filename_for( story )
      filepath = File.join Rails.root, Sorcery.config.story.filepath
      filename_and_path = File.join( filepath, filename )
      create_file( story, filename_and_path, format ) unless File.exist?( filename_and_path )
      if File.exist?( filename_and_path )
        send_file( filename_and_path, type: Sorcery.config.story.formats[ format.to_sym ].mime )
      else
        flash[:error] = "Attempt to create [#{format}] file for story failed.  Please report the error to management."
        redirect_to story        
      end
    else
      flash[:error] = "Format [#{format}] is not supported.  Sorry."
      redirect_to story
    end
  end
  
  def filename_for( story )
    "banned_sorcery.#{story.id}-#{story.title.parameterize("_")}.#{params[:format]}"
  end
  
  def format_enabled?( format )
    Sorcery.config.story.formats[ format.to_sym ].status == "enabled"
  end
  
  # If the given story doesn't exist in the requested file format, build it.
  def create_file( story, filename, format )
    html = render_to_string partial: "/stories/story_complete_simple_html", object: story, format: "html", layout: false

    case format.to_sym
    when :pdf                                      # "Attempt to create PDF"
      tempfile do |t|
        t.write( html )
        t.flush
        `htmldoc --fontspacing 1.2 --fontsize 17pt --no-title --no-toc -f #{filename}.html #{t.path}`  # for debugging purposes
        `htmldoc -t pdf --fontspacing 1.2 --fontsize 17pt --no-title --no-toc -f #{filename} #{t.path}`
      end
    when :mobi
      puts "No mobi!"
    when :epub                                     # Attempt to create ePub
      ident = story_url(story)
      File.open "#{filename}.html", "w" do |f|
        f.write( html )
        f.flush
        epub = EeePub.make do
          title       story.title
          creator     "Bryce Anderson"           # TODO: should be story.author, but haven't implemented it yet
          publisher   "bannedsorcery.org"
          date        story.updated_at.strftime("%Y-%m-%d")
          identifier  ident, scheme: "URI"
          files [f.path]
        end
        
        epub.save( filename )
      end
    else
      puts "No #{format}!"
    end
  end
end
