class CreateUserFiles < ActiveRecord::Migration
  def change
    create_table :user_files do |t|
      t.string :file
      t.text :notes
      t.integer :attached_to_id
      t.string :attached_to_type
      t.integer :owner_id
      
      t.timestamps
    end
  end
end
