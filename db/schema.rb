# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_24_010637) do

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.integer "year_born"
    t.integer "year_of_death"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "books", force: :cascade do |t|
    t.string "title", null: false
    t.integer "page_count"
    t.integer "author_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "subtitle"
    t.string "url"
    t.string "cover_url"
    t.string "isbn"
    t.index ["author_id"], name: "index_books_on_author_id"
    t.index ["title"], name: "index_books_on_title", unique: true
  end

  add_foreign_key "books", "authors"
end
