class Book < ActiveRecord::Base
  include BookCoverImageSupport
  has_many :tweet_quotes
  
  def author
    Author.find(1) # stub
  end
  
  def new_tweet_quote
    TweetQuote.new( book: self )
  end
end
