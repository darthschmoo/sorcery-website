class CreateSiteThemeAssets < ActiveRecord::Migration
  def change
    create_table :site_theme_assets do |t|
      t.integer :site_theme_id
      t.string :type
      t.string :key
      t.string :file

      t.timestamps
    end
  end
end
