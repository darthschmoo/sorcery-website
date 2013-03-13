class Book < ActiveRecord::Base
  include BookCoverImageSupport
  has_many :tweet_quotes
  has_many :files, as: :attached_to, class_name: "UserFile" 
  
  def author
    Author.find(1) # stub
  end
  
  def new_tweet_quote
    TweetQuote.new( book: self )
  end
end
