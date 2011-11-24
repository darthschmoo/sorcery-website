class CreateSocialMediaLinks < ActiveRecord::Migration
  def change
    create_table :social_media_links do |t|
      t.integer :author_id
      t.string  :link
      t.string  :source   # Twitter, GPlus, etc.  Need to decide which ones to support, or come up with an open framework.

      t.timestamps
    end
  end
end
