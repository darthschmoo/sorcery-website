class CreateTweetQuotes < ActiveRecord::Migration
  def change
    create_table :tweet_quotes do |t|
      t.string :text
      t.integer :book_id
      t.datetime :last_tweeted_on, :default => "1900-01-01 00:00:00"
      
      t.timestamps
    end
  end
end
