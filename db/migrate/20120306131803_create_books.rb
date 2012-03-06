class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :teaser
      t.string :image
      t.text :summary
      t.boolean :published

      t.timestamps
    end
  end
end
