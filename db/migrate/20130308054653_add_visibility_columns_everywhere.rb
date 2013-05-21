class Story < ActiveRecord::Base; end

class AddVisibilityColumnsEverywhere < ActiveRecord::Migration
  def up
    change_table( :book_reviews ) do |t|
      t.string( :visibility, :default => "owner" ) unless t.column_exists?( :visibility )
      t.integer :author_id                         unless t.column_exists?( :author_id )
    end
    
    change_table( :pages ) do |t|
      t.string( :visibility, :default => "owner" ) unless t.column_exists?( :visibility )
      t.integer( :author_id )                      unless t.column_exists?( :author_id )
    end
    
    change_table( :stories ) do |t|
      t.string( :visibility, :default => "owner" ) unless t.column_exists?( :visibility )
      t.integer( :author_id )                      unless t.column_exists?( :author_id )
      
      if t.column_exists?( :published ) && t.column_exists?( :visibility )
        for story in Story.all
          if story.published?
            story.update_attribute( :visibility, "public" )
          end
        end

        t.remove( :published )
      end
    end
    
    change_table( :user_files ) do |t|  
      t.string( :visibility, :default => "owner" ) unless t.column_exists?( :visibility )
    end
  end
  
  def down
    change_table( :book_reviews ) do |t|
      t.remove( :visibility )  if t.column_exists?( :visibility )
      t.remove( :author_id )   if t.column_exists?( :author_id )
    end
    
    change_table( :pages ) do |t|
      t.remove( :visibility )  if t.column_exists?( :visibility )
      t.remove( :author_id )   if t.column_exists?( :author_id )
    end
    
    change_table( :stories ) do |t|
      t.boolean( :published, :default => false ) unless t.column_exists?( :published )
            
            
      if t.column_exists?( :visibility )
        for story in Story.all
          if story.visibility == "owner"
            t.update_attribute :published, true
          end
        end
      
        t.remove( :visibility )
      end
    end
    
    change_table( :user_files ) do |t|  
      t.remove :visibility if t.column_exists?( :visibility )
      t.remove :author_id  if t.column_exists?( :author_id )
    end
  end
end
