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

ActiveRecord::Schema.define(:version => 20131123160737) do

  create_table "articles", :force => true do |t|
    t.text     "line"
    t.string   "url"
    t.string   "vendor"
    t.string   "news_time"
    t.string   "genre"
    t.string   "cat"
    t.string   "subcat"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "genre_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "env_nr4s", :force => true do |t|
    t.integer  "sort_genre"
    t.integer  "sort_category"
    t.integer  "genre_id"
    t.integer  "category_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "genres", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "histories", :force => true do |t|
    t.text     "line"
    t.string   "url"
    t.string   "vendor"
    t.string   "news_time"
    t.string   "genre"
    t.string   "cat"
    t.string   "subcat"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "key_word_sets", :force => true do |t|
    t.string   "genre"
    t.string   "category"
    t.text     "keywords"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "keywords", :force => true do |t|
    t.string   "name"
    t.integer  "genre_id"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "nr4_admin_nr4s", :force => true do |t|
    t.integer  "sort_genre"
    t.integer  "sort_category"
    t.integer  "genre_id"
    t.integer  "category_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "nr4_env_nr4s", :force => true do |t|
    t.integer  "sort_genre"
    t.integer  "sort_category"
    t.integer  "genre_id"
    t.integer  "category_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "settings", :force => true do |t|
    t.boolean  "mobile_view"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "settings_nr4s", :force => true do |t|
    t.integer  "sort_genre"
    t.integer  "sort_category"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "filter_genre"
    t.integer  "filter_category"
  end

end
