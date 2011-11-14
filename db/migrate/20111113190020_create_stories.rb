class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string  :title
      t.string  :teaser
      t.text    :body
      t.string  :status
      t.boolean :published, :default => false
      t.text    :author_notes
      
      t.timestamps
    end
  end
end
