class TweetQuote < ActiveRecord::Base
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
    tweet = self.tweeted_on_before(3.months.ago).random.first
    if TwitterGateway.write( tweet.text )
      tweet.update_attribute( :last_tweeted_on, Time.now )
    end
  end
end
