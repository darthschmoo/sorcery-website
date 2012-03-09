class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :teaser
      t.string :image
      
      t.text :summary
      t.text :how_to_buy
      t.boolean :published

      t.timestamps
    end
  end
end
