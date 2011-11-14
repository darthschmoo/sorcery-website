class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string   :name
      t.string   :short_bio
      t.text     :long_bio

      t.timestamps
    end
  end
end
