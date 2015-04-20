class CreateSiteThemes < ActiveRecord::Migration
  def change
    create_table :site_themes do |t|
      t.integer :author_id
      t.string :name
      t.text :description
      t.string :screenshot

      t.timestamps
    end
  end
end
