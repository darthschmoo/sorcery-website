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
      format.pdf  { serve_format @story }
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
    @story.author = current_author

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
  
  def test
    
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
      redirect_to story.url_for( format )
    else
      flash[:error] = "Format [#{format}] is not supported.  Sorry."
      redirect_to story
    end
  end

  def format_enabled?( format )
    Story::SUPPORTED_FORMATS.include?( format )
  end
  

end
