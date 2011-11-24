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

ActiveRecord::Schema.define(:version => 20111120155204) do

  create_table "authors", :force => true do |t|
    t.text     "name"
    t.text     "short_bio"
    t.text     "long_bio"
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
  end

end