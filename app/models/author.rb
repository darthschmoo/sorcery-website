class Author < ActiveRecord::Base
  has_many :social_media_links, :dependent => :destroy
  has_many :site_theme
  has_many :photos, as: :attached_to, class_name: "UserFile" 
  
  acts_as_authentic do |c|
    # c.key = "value"  or some such nonsense
  end
  
  def self.primary
    first
  end
  
  def theme
    (self.site_themes.active + SiteTheme.default).first
  end
end
