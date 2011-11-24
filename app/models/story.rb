class Story < ActiveRecord::Base
  scope :published, where( "published = TRUE")
  scope :unpublished, where( "published = FALSE")
  scope :recent, lambda { |num_days = 30| where("created_at > ?", num_days.days.ago ) }
  
  def word_count
    body ? body.length / 6 : 0
  end
end
