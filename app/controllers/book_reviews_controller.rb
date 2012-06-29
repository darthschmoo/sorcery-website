class BookReviewsController < ApplicationController
  before_filter :must_be_logged_in, only: %w(new edit create update destroy)
  before_filter :get_book_review, only: %w(edit update show destroy)
  
  def index
    @book_reviews = BookReview.order("created_at DESC").paginate(per_page: 5, page: params[:page])
    standard_response( @book_reviews )
  end

  def new
    @book_review = BookReview.new
  end
  
  def create
    @book_review = BookReview.new params[:book_review]
    standard_save_on_create_response @book_review
  end

  def edit
    #empty
  end

  def update
    standard_update_record_response @book_review, params[:book_review]
  end

  def show
    standard_response( @book_review )
  end

  def destroy
    raise "You never wrote this!"
  end
  
  def test
    render layout: false
  end
  
  protected
  def get_book_review
    @book_review = BookReview.find_by_id( params[:id] )
    abandon_action( "No book review found with id #{params[:id]}.") if @book_review.nil?
  end
end
