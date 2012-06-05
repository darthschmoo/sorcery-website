class CreateBookReviews < ActiveRecord::Migration
  def change
    create_table :book_reviews do |t|
      t.string :title
      t.string :rating
      t.string :cover_image
      t.string :book_title
      t.string :book_author
      t.string :book_link
      t.text :summary
      t.text :review

      t.timestamps
    end
  end
end
