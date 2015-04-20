class SiteTheme < ActiveRecord::Base
  attr_accessible :author_id, :description, :name, :screenshot
  
  #has_many :site_theme_assets, as: :assets
  
  scope :defaults, where( :name => "default" )
  
  def self.default
    self.defaults.first 
  end
end
