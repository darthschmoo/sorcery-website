class LogRemoteIps < ActiveRecord::Migration
  def up
    change_table :log_requests do |t|
      t.string :remote_addr
    end
  end

  def down
    change_table :log_requests do |t|
      t.remove :remote_addr
    end
  end
end
