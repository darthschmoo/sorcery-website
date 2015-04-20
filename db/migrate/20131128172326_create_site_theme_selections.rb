class CreateSiteThemeSelections < ActiveRecord::Migration
  def change
    create_table :site_theme_selections do |t|
      t.integer :site_theme_id
      t.integer :author_id
      t.boolean :active

      t.timestamps
    end
  end
end
