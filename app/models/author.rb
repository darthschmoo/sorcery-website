class Author < ActiveRecord::Base
  has_many :social_media_links, :dependent => :destroy
  
  acts_as_authentic do |c|
    # c.key = "value"  or some such nonsense
  end
  
  def self.primary
    first
  end
end
