class Page < ActiveRecord::Base
  validates_uniqueness_of :slug
  validates_format_of :slug, with: %r(^/([/a-z0-9_-]+)*$), message: "Leading slash, followed by Lower-case letters, numbers, dashes, and underscores only. More slashes to create subdirectories."
  
  # before_save do
  #   self.parent = Page.find_by_slug( self.parent_slug )
  # end
  # 
  # def parent_slug
  #   bits = slug.split("/")
  #   
  #   case bits.length
  #   when 0
  #     nil
  #   when 2
  #     "/"
  #   else
  #     bits[0..-2].join("/")
  #   end
  # end
  
  # finding children would be more difficult.  Regular expressions in the db?
  # all descendants:  where slug LIKE "#{slug}/%"
  
  def self.tree
    PageTree.new
  end
  
  def self.root
    Page.find_by_slug("/")
  end
  
  def self.directory_sorted
    PageTree.new.to_a
  end
  
  def root?
    slug == "/"
  end
  
  def child_slug( str = "" )
    self.slug + ( root? ? "" : "/" ) + ( str.blank? ? "XXXXX" : str )
  end
end
