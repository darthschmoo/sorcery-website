class Story < ActiveRecord::Base
  scope :published, where( "published = TRUE")
  scope :unpublished, where( "published = FALSE")
  scope :recent, lambda { |num_days = 30| where("created_at > ?", num_days.days.ago ) }
end
