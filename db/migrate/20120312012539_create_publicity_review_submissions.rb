class CreatePublicityReviewSubmissions < ActiveRecord::Migration
  def change
    create_table :publicity_review_submissions do |t|
      t.integer :book_id
      t.integer :reviewer_id
      t.text :notes

      t.timestamps
    end
  end
end
