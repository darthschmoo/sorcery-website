class BooksController < ApplicationController
  before_filter :must_be_logged_in, except: %w(index show)
  before_filter :get_book, except: %w(index new create)
  before_filter :book_must_be_published_unless_owner, except: %w(index)
  before_filter :book_must_have_project_path, only: %w(sign send_signed_copy)
  
  def index
    @books = Book.all
    standard_response( @books )
  end
  
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new( params[:book] )
    standard_save_on_create_response( @book )
  end
  
  def edit
    #empty
  end
  
  def update
    standard_update_record_response( @book, params[:book] )
  end
  
  def show
    standard_response( @book )
  end
  
  def destroy
    raise "You never wrote this!"
  end
  
  # Get info for the signature
  def sign
    
    @ebook_signature = EbookSignature.new( book: @book )
  end
  
  def send_signed_copy
    def handle_errors( &block )
      yield
    rescue Exception => e
      @errors ||= []
      @errors.push( e.to_html_snippet )
    end
    
    @ebook_signature = EbookSignature.new( params[:ebook_signature] )
    @ebook_signature.book = @book
    
    # "pdf|epub|mobi"
    @ebook_signature.formats = params[:book_format].map{ |format, val|
      val == "1" ? format.to_s : nil
    }.compact.join("|")
      
    formats = [:epub, :pdf, :mobi]
    
    for format in formats
      file = @book.absolute_project_path.join( "the_improbable_rise_of_singularity_girl.#{format}" )
      FileUtils.rm( file ) if file.exist?
    end
    
    debugger
    
    sig_html = <<-EOS
<?xml version="1.0" encoding="utf-8" standalone="no"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
  "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>#{@book.title}, by #{@book.author.name}</title>
  <link href="../Styles/style.css" media="screen" rel="stylesheet" type="text/css" />  
</head>

<body id="sig">    
  <p class="name">#{@ebook_signature.name},</p>
  
  <div class="message">
    #{ ApplicationHelper.markdown( @ebook_signature.message ) }
  </div>
  
  <div class="sig">
    <img style="float:right" src="../Images/bryce.png" alt="Bryce Anderson signed this"/>
  </div>
</body>
</html>
EOS

    @book.absolute_project_path.join( "book", "sig.xhtml" ).write( sig_html )
    
    @should_pdf  = params[:book_format][:pdf]  == "1" 
    @should_mobi = params[:book_format][:mobi] == "1"
    @should_epub = params[:book_format][:epub] == "1"
    
    @files = []
    @errors = []
    
    [ ["forge",  :epub, @should_epub], 
      ["mobify", :mobi, @should_mobi]    #, 
      # ["pdfify", :pdf,  @should_pdf ] 
      ].each do |forge_command, format, should_be_done|
      if should_be_done
        handle_errors do
          rundesc = EpubForge::Action::Runner.new.exec( forge_command, @book.absolute_project_path )
          if rundesc.success? && (file = @book.absolute_project_path.join( "the_improbable_rise_of_singularity_girl.#{format}" ) ).exist?
            @files.push( file )
          else
            @errors.push( "Could not sign book in format #{format}" )
          end
        end
      end
    end
    
    unless @files.empty?
      handle_errors do
        puts "Sending to gmail"
        response = BookMailer.send_signed_copy( @book, @files, @ebook_signature ).deliver!
      end
    end
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
  
  def book_must_have_project_path
    unless @book.absolute_project_path && EpubForge::Project.is_project_dir?( @book.absolute_project_path )
      abandon_action( "Book needs an epubforge project path.", edit_book_path( @book ) )
      return false
    end
    
    true
  end
end
