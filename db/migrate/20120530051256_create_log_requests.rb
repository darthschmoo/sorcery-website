class CreateLogRequests < ActiveRecord::Migration
  def change
    create_table :log_requests do |t|
      t.string :request_params
      t.string :request_uri
      t.string :user_agent
      t.string :formats

      t.timestamps
    end
  end
end
