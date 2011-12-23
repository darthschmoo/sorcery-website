class LinkStoryToAuthor < ActiveRecord::Migration
  def change
    change_table :stories do |t|
      t.integer  :author_id
    end
  end
end
