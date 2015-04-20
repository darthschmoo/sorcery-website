class SiteThemeAsset < ActiveRecord::Base
  attr_accessible :file, :key, :site_theme_id, :type
  
  belongs_to :site_theme, as: :theme
  
end
