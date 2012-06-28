class CreateBookSubmissions < ActiveRecord::Migration
  def change
    create_table :book_submissions do |t|
      t.string :book_title
      t.string :book_author
      t.string :author_email
      t.string :book_link
      t.string :file
      t.text   :message
      t.string :state, default: "pending"
      
      t.timestamps
    end
  end
end
