include Publicity
class Publicity::ReviewersController < ApplicationController
  # layout nil
  before_filter :must_be_logged_in
  before_filter :get_reviewer, only: %w(edit update show destroy new_submission submitted_for_review)
  
  def index
    @reviewers = Reviewer.all
    standard_response( @reviewers )
  end
  
  def new
    @reviewer = Reviewer.new
  end

  def create
    @reviewer = Reviewer.new params[:publicity_reviewer]
    standard_save_on_create_response @reviewer
  end

  def edit
    #empty
  end

  def update
    standard_update_record_response @reviewer, params[:publicity_reviewer]
  end

  def show
    standard_response( @reviewer )
  end

  def destroy
    raise "You never wrote this!"
  end
  
  def new_submission
    @review_submission = ReviewSubmission.new
    @books = Book.all
  end
  
  def submitted_for_review
    @review_submission = ReviewSubmission.new params[:review_submission]
    @review_submission.reviewer = @reviewer
    
    if @review_submission.save
      flash[:notice] = "Review submission saved"
      redirect_to action: "show", id: @reviewer
    else
      flash.now[:error] = "Review submission not recorded"
      render "new_submission"
    end
  end
  
  protected
  def get_reviewer
    @reviewer = Reviewer.find_by_id( params[:id] )
    abandon_action( "No reviewer found with id #{params[:id]}.") if @reviewer.nil?
  end
  
end
