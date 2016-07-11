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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  create_table "authors", force: :cascade do |t|
    t.text "name",              null: false
    t.text "sort"
    t.text "link", default: "", null: false
    t.index ["name"], name: "sqlite_autoindex_authors_1", unique: true
  end

  create_table "books", force: :cascade do |t|
    t.text     "title",         default: "Unknown",             null: false
    t.text     "sort"
    t.datetime "timestamp"
    t.datetime "pubdate"
    t.float    "series_index",  default: "1.0",                 null: false
    t.text     "author_sort"
    t.text     "isbn",          default: ""
    t.text     "lccn",          default: ""
    t.text     "path",          default: "",                    null: false
    t.integer  "flags",         default: 1,                     null: false
    t.text     "uuid"
    t.boolean  "has_cover",     default: "0"
    t.datetime "last_modified", default: '2000-01-01 00:00:00', null: false
    t.index ["author_sort"], name: "authors_idx"
    t.index ["sort"], name: "books_idx"
  end

  create_table "books_authors_link", force: :cascade do |t|
    t.integer "book",   null: false
    t.integer "author", null: false
    t.index ["author"], name: "books_authors_link_aidx"
    t.index ["book", "author"], name: "sqlite_autoindex_books_authors_link_1", unique: true
    t.index ["book"], name: "books_authors_link_bidx"
  end

  create_table "books_languages_link", force: :cascade do |t|
    t.integer "book",                   null: false
    t.integer "lang_code",              null: false
    t.integer "item_order", default: 0, null: false
    t.index ["book", "lang_code"], name: "sqlite_autoindex_books_languages_link_1", unique: true
    t.index ["book"], name: "books_languages_link_bidx"
    t.index ["lang_code"], name: "books_languages_link_aidx"
  end

  create_table "books_plugin_data", force: :cascade do |t|
    t.integer "book", null: false
    t.text    "name", null: false
    t.text    "val",  null: false
    t.index ["book", "name"], name: "sqlite_autoindex_books_plugin_data_1", unique: true
  end

  create_table "books_publishers_link", force: :cascade do |t|
    t.integer "book",      null: false
    t.integer "publisher", null: false
    t.index ["book"], name: "books_publishers_link_bidx"
    t.index ["book"], name: "sqlite_autoindex_books_publishers_link_1", unique: true
    t.index ["publisher"], name: "books_publishers_link_aidx"
  end

  create_table "books_ratings_link", force: :cascade do |t|
    t.integer "book",   null: false
    t.integer "rating", null: false
    t.index ["book", "rating"], name: "sqlite_autoindex_books_ratings_link_1", unique: true
    t.index ["book"], name: "books_ratings_link_bidx"
    t.index ["rating"], name: "books_ratings_link_aidx"
  end

  create_table "books_series_link", force: :cascade do |t|
    t.integer "book",   null: false
    t.integer "series", null: false
    t.index ["book"], name: "books_series_link_bidx"
    t.index ["book"], name: "sqlite_autoindex_books_series_link_1", unique: true
    t.index ["series"], name: "books_series_link_aidx"
  end

  create_table "books_tags_link", force: :cascade do |t|
    t.integer "book", null: false
    t.integer "tag",  null: false
    t.index ["book", "tag"], name: "sqlite_autoindex_books_tags_link_1", unique: true
    t.index ["book"], name: "books_tags_link_bidx"
    t.index ["tag"], name: "books_tags_link_aidx"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "book", null: false
    t.text    "text", null: false
    t.index ["book"], name: "comments_idx"
    t.index ["book"], name: "sqlite_autoindex_comments_1", unique: true
  end

  create_table "conversion_options", force: :cascade do |t|
    t.text    "format", null: false
    t.integer "book"
    t.binary  "data",   null: false
    t.index ["book"], name: "conversion_options_idx_b"
    t.index ["format", "book"], name: "sqlite_autoindex_conversion_options_1", unique: true
    t.index ["format"], name: "conversion_options_idx_a"
  end

  create_table "custom_columns", force: :cascade do |t|
    t.text "label",                          null: false
    t.text "name",                           null: false
    t.text "datatype",                       null: false
    t.boolean "mark_for_delete", default: "0",  null: false
    t.boolean "editable",        default: "1",  null: false
    t.text "display",         default: "{}", null: false
    t.boolean "is_multiple",     default: "0",  null: false
    t.bolean "normalized",                     null: false
    t.index ["label"], name: "custom_columns_idx"
    t.index ["label"], name: "sqlite_autoindex_custom_columns_1", unique: true
  end

  create_table "data", force: :cascade do |t|
    t.integer "book",              null: false
    t.text    "format",            null: false
    t.integer "uncompressed_size", null: false
    t.text    "name",              null: false
    t.index ["book", "format"], name: "sqlite_autoindex_data_1", unique: true
    t.index ["book"], name: "data_idx"
    t.index ["format"], name: "formats_idx"
  end

  create_table "feeds", force: :cascade do |t|
    t.text "title",  null: false
    t.text "script", null: false
    t.index ["title"], name: "sqlite_autoindex_feeds_1", unique: true
  end

  create_table "identifiers", force: :cascade do |t|
    t.integer "book",                  null: false
    t.text    "type", default: "isbn", null: false
    t.text    "val",                   null: false
    t.index ["book", "type"], name: "sqlite_autoindex_identifiers_1", unique: true
  end

  create_table "languages", force: :cascade do |t|
    t.text "lang_code", null: false
    t.index ["lang_code"], name: "languages_idx"
    t.index ["lang_code"], name: "sqlite_autoindex_languages_1", unique: true
  end

  create_table "library_id", force: :cascade do |t|
    t.text "uuid", null: false
    t.index ["uuid"], name: "sqlite_autoindex_library_id_1", unique: true
  end

  create_table "metadata_dirtied", force: :cascade do |t|
    t.integer "book", null: false
    t.index ["book"], name: "sqlite_autoindex_metadata_dirtied_1", unique: true
  end

  create_table "preferences", force: :cascade do |t|
    t.text "key", null: false
    t.text "val", null: false
    t.index ["key"], name: "sqlite_autoindex_preferences_1", unique: true
  end

  create_table "publishers", force: :cascade do |t|
    t.text "name", null: false
    t.text "sort"
    t.index ["name"], name: "publishers_idx"
    t.index ["name"], name: "sqlite_autoindex_publishers_1", unique: true
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "rating"
    t.index ["rating"], name: "sqlite_autoindex_ratings_1", unique: true
  end

  create_table "series", force: :cascade do |t|
    t.text "name", null: false
    t.text "sort"
    t.index ["name"], name: "series_idx"
    t.index ["name"], name: "sqlite_autoindex_series_1", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.text "name", null: false
    t.index ["name"], name: "sqlite_autoindex_tags_1", unique: true
    t.index ["name"], name: "tags_idx"
  end

end
