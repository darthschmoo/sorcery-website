class CreateEbookSignatures < ActiveRecord::Migration
  def change
    create_table :ebook_signatures do |t|
      t.string  :name
      t.string  :email
      t.text    :message
      t.string  :formats
      t.integer :book_id
      
      t.timestamps
    end
  end
end
