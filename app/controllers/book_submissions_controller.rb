class BookSubmissionsController < ApplicationController
  before_filter :must_be_logged_in, except: [:new, :create]
  before_filter :get_book_submission, only: [:show, :download]
  
  def new
    @book_submission = BookSubmission.new( params[:book_submission] )
  end

  def create
    @book_submission = BookSubmission.new params[:book_submission]
    
    if @book_submission.save
      respond_to do |format|
        format.html { 
          redirect_to book_reviews_path, notice: "Your file has been submitted."
          return false
        }
        format.json { render json: @book_submission, status: :created, location: @book_submission }
      end  
    else
      respond_to do |format|
        format.html { render action: "new", error: "Submission failed." }
        format.json { render json: @book_submission.errors, status: :unprocessable_entity }
      end
    end    
  end
  
  def index
    @book_submissions = BookSubmission.paginate( per_page: 5, page: params[:page] )
  end
  
  def show
  end
  
  def approved
  end
  
  def rejected
  
  end
  
  def download
    file = File.join( BookSubmission::SUBMISSIONS_FOLDER, @book_submission.file )
    
    if File.exist?( file )
      send_file file, filename: @book_submission.file, type: @book_submission.mimetype
    else
      render text: "No such file.", status: 404
    end
  end

  protected
  def get_book_submission
    @book_submission = BookSubmission.find_by_id( params[:id] )
    abandon_action( "No submission found with id #{params[:id]}.") if @book_submission.nil?
  end
end
