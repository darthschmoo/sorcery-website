class Book < ActiveRecord::Base
  include BookCoverImageSupport
  has_many :tweet_quotes
  has_many :files, as: :attached_to, class_name: "UserFile" 
  has_many :ebook_signatures
  
  def author
    Author.find(1) # stub
  end
  
  def new_tweet_quote
    TweetQuote.new( book: self )
  end
  
  def absolute_project_path
    if self.project_path
      Sorcery.config.book.epubforge_projects_dir.fwf_filepath.expand.join( self.project_path )
    else
      nil
    end
  end
end
