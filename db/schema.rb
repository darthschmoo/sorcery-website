# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120315141133) do

  create_table "authors", :force => true do |t|
    t.text     "name"
    t.text     "short_bio"
    t.text     "long_bio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
  end

  create_table "books", :force => true do |t|
    t.string   "title"
    t.string   "teaser"
    t.string   "image"
    t.text     "summary"
    t.text     "how_to_buy"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "slug"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publicity_review_submissions", :force => true do |t|
    t.integer  "book_id"
    t.integer  "reviewer_id"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publicity_reviewers", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "email"
    t.string   "status"
    t.string   "guidelines"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "social_media_links", :force => true do |t|
    t.integer  "author_id"
    t.string   "link"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stories", :force => true do |t|
    t.string   "title"
    t.string   "teaser"
    t.text     "body"
    t.string   "status"
    t.boolean  "published",    :default => false
    t.text     "author_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "author_id"
  end

  create_table "tweet_quotes", :force => true do |t|
    t.string   "text"
    t.integer  "book_id"
    t.datetime "last_tweeted_on", :default => '1977-01-01 00:00:00'
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
