class BooksController < ApplicationController
  before_filter :must_be_logged_in, only: %w(new edit create update destroy)
  before_filter :get_book, only: %w(edit update show destroy)
  before_filter :book_must_be_published_unless_owner, except: %w(index)
  
  
  def index
    @books = Book.all
    standard_response( @books )
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new params[:book]
    standard_save_on_create_response @book
  end

  def edit
    #empty
  end

  def update
    standard_update_record_response @book, params[:book]
  end

  def show
    standard_response( @book )
  end

  def destroy
    raise "You never wrote this!"
  end
  
  protected
  def get_book
    @book = Book.find_by_id( params[:id] )
    abandon_action( "No book found with id #{params[:id]}.") if @book.nil?
  end
  
  def book_must_be_published_unless_owner
    unless !@book || current_author == @book.author
      abandon_action( "This book is not visible to the public." )
    end
  end
end
