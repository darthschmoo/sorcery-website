class BooksController < ApplicationController
  before_filter :must_be_logged_in, except: %w(index show)
  before_filter :get_book, except: %w(index new create)
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
  
  def sign
    @sig = EbookSignature.new( author: @author )
  end
  
  def send_signed_copy
    
  end
  
  def attach_file
    @book_file = UserFile.new
    @book_file.attached_to = @book
  end
  
  def file_attached
    @book_file = UserFile.new( params[:user_file] )
    @book_file.owner = @author
    @book.files << @book_file

    respond_to do |format|
       format.html { redirect_to @book, notice: "File attached to book."}
       format.json { render json: @book_file, status: :created, location: @book_file }
     end
  end
  
  protected
  def get_book
    @book = Book.find_by_id( params[:id] )
    abandon_action( "No book found with id #{params[:id]}.") if @book.nil?
  end
  
  def book_must_be_published_unless_owner
    unless !@book || @book.published? || current_author == @book.author
      abandon_action( "This book is not visible to the public." )
    end
  end
end
