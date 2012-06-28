class StandardizeCoverImageField < ActiveRecord::Migration
  def change 
    rename_column :books, :image, :cover_image
  end
end
