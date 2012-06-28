class PagesController < ApplicationController
  before_filter :must_be_logged_in, :except => %w(show)
  
  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all

    standard_response @pages
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    if params[:slug]
      @page = Page.find_by_slug( params[:slug] )
      if @page.nil?
        if params[:slug] == "/"
          @page = create_default_root_page
        elsif logged_in?
          redirect_to new_page_path( page: { slug: params[:slug] } )
          return false
        else
          render template: "404", status: 404
          return false
        end
      end
    else
      @page = Page.find(params[:id])
    end

    standard_response @page
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.new( params[:page] )

    standard_response @page
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])

    standard_save_on_create_response @page
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page.find(params[:id])
    
    standard_update_record_response @page, params[:page]
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :ok }
    end
  end
  
  protected
  def create_default_root_page
    page = Page.new( :slug => "/", :title => "Welcome Home", :content => "# Hello world\n\nThis is your page!" )
    page.save
    
    page
  end
end
