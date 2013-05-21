class AddProjectPathToBook < ActiveRecord::Migration
  def change
    change_table( :books ) do |t|
      t.string :project_path, default: nil
    end
  end
end
