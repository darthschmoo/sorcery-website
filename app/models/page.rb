class Page < ActiveRecord::Base
  validates_uniqueness_of :slug
  validates_format_of :slug, with: %r((/[a-z0-9_-]*)+), message: "Lower-case letters, numbers, dashes, and underscores only"
  
  before_save do
    self.parent = Page.find_by_slug( self.parent_slug )
  end
  
  def parent_slug
    bits = slug.split("/")
    
    case bits.length
    when 0
      nil
    when 2
      "/"
    else
      bits[0..-2].join("/")
    end
  end
  
  # finding children would be more difficult.  Regular expressions in the db?
  # all descendants:  where slug LIKE "#{slug}/%"
end
