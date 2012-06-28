require 'test_helper'

class BookReviewsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @book_review = Factory(:book_review)
    assert_false @book_review.new_record?
  end
  
  test "basics when not logged in" do
    
  end
  
  test "basics when logged in" do
    
  end
end
