class AuthorsController < ApplicationController
  before_filter :must_be_logged_in, :except => %w(show)
  before_filter :get_author, :only => %w(show edit update destroy)
  # GET /authors
  # GET /authors.json
  def index
    @authors = Author.all

    standard_response @authors
  end

  # GET /authors/1
  # GET /authors/1.json
  def show
    standard_response @author
  end

  # GET /authors/new
  # GET /authors/new.json
  def new
    @author = Author.new
    
    standard_response @author
  end

  # GET /authors/1/edit
  def edit
    # empty
  end

  # POST /authors
  # POST /authors.json
  def create
    @author = Author.new( params[:author] )
    standard_save_on_create_response( @author )
  end

  # PUT /authors/1
  # PUT /authors/1.json
  def update
    standard_update_record_response @author, params[:author]
  end

  # DELETE /authors/1
  # DELETE /authors/1.json
  def destroy
    @author.destroy

    respond_to do |format|
      format.html { redirect_to authors_url }
      format.json { head :ok }
    end
  end


  

  protected
  def get_author
    @author = Author.find_by_id( params[:id] )
    abandon_action( "No such person as author #{params[:id]}.") if @author.nil?
  end
end
