class CreatePublicityReviewers < ActiveRecord::Migration
  def change
    create_table :publicity_reviewers do |t|
      t.string :name
      t.string :url
      t.string :email
      t.string :status
      t.string :guidelines
      t.text :notes

      t.timestamps
    end
  end
end
