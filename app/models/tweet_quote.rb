class TweetQuote < ActiveRecord::Base
  TIME_BETWEEN_TWEEPEATS = 3.months.ago
  
  belongs_to :book
  include Pacecar
  
  scope :random, lambda { 
    if self.count == 0
      return nil
    else
      offset( rand(self.count) ).limit(1)
    end
  }
  
  def self.send_publicity_tweet
    tweet = self.tweeted_on_before(TIME_BETWEEN_TWEEPEATS).random.first
    if TwitterGateway.write( tweet.text )
      tweet.mark_as_just_tweeted
    end
  end
  
  def mark_as_just_tweeted
    tweet.update_attribute( :last_tweeted_on, Time.now )
  end
end
