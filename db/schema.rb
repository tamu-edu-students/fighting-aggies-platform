# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_01_06_025946) do
  create_table "analyses", force: :cascade do |t|
    t.json "report"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "video_id"
    t.index ["video_id"], name: "index_analyses_on_video_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "role"
    t.string "email"
  end

  create_table "videos", force: :cascade do |t|
    t.string "video_path"
    t.string "thumbnail_path"
    t.string "resolution"
    t.integer "size"
    t.integer "duration"
    t.float "frame_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "visions", force: :cascade do |t|
    t.json "report"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "video_id"
    t.index ["video_id"], name: "index_visions_on_video_id"
  end

  add_foreign_key "analyses", "videos"
  add_foreign_key "visions", "videos"
end
