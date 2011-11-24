class Author < ActiveRecord::Base
  has_many :social_media_links, :dependent => :destroy
  
  def self.primary
    first
  end
end
