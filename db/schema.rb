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

ActiveRecord::Schema.define(:version => 20131128172326) do

  create_table "authors", :force => true do |t|
    t.string   "name"
    t.string   "short_bio"
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

  create_table "book_reviews", :force => true do |t|
    t.string   "title"
    t.string   "rating"
    t.string   "cover_image"
    t.string   "book_title"
    t.string   "book_author"
    t.string   "book_link"
    t.text     "summary"
    t.text     "review"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "visibility",  :default => "owner"
    t.integer  "author_id"
  end

  create_table "book_submissions", :force => true do |t|
    t.string   "book_title"
    t.string   "book_author"
    t.string   "author_email"
    t.string   "book_link"
    t.string   "file"
    t.text     "message"
    t.string   "state",        :default => "pending"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", :force => true do |t|
    t.string   "title"
    t.string   "teaser"
    t.string   "cover_image"
    t.text     "summary"
    t.text     "how_to_buy"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "project_path"
  end

  create_table "ebook_signatures", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.string   "formats"
    t.integer  "book_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "log_requests", :force => true do |t|
    t.string   "request_params"
    t.string   "request_uri"
    t.string   "user_agent"
    t.string   "formats"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remote_addr"
  end

  create_table "pages", :force => true do |t|
    t.string   "slug"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "visibility", :default => "owner"
    t.integer  "author_id"
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

  create_table "site_theme_assets", :force => true do |t|
    t.integer  "site_theme_id"
    t.string   "type"
    t.string   "key"
    t.string   "file"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "site_theme_selections", :force => true do |t|
    t.integer  "site_theme_id"
    t.integer  "author_id"
    t.boolean  "active"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "site_themes", :force => true do |t|
    t.integer  "author_id"
    t.string   "name"
    t.text     "description"
    t.string   "screenshot"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
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
    t.text     "author_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "author_id"
    t.string   "visibility",   :default => "owner"
  end

  create_table "tweet_quotes", :force => true do |t|
    t.string   "text"
    t.integer  "book_id"
    t.datetime "last_tweeted_on", :default => '1900-01-01 00:00:00'
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_files", :force => true do |t|
    t.string   "file"
    t.text     "notes"
    t.integer  "attached_to_id"
    t.string   "attached_to_type"
    t.integer  "owner_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "visibility",       :default => "owner"
  end

end
