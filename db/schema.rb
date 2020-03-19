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

ActiveRecord::Schema.define(version: 2020_03_19_222036) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "device_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devices", force: :cascade do |t|
    t.string "name"
    t.bigint "device_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_type_id"], name: "index_devices_on_device_type_id"
  end

  create_table "documentations", force: :cascade do |t|
    t.string "title"
    t.string "file"
    t.bigint "machine_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["machine_id"], name: "index_documentations_on_machine_id"
  end

  create_table "group_inputs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inputs", force: :cascade do |t|
    t.bigint "device_id"
    t.bigint "group_input_id"
    t.string "name"
    t.string "value"
    t.boolean "is_error", default: false
    t.string "message_error"
    t.string "hint_error"
    t.datetime "client_time"
    t.bigint "request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_inputs_on_device_id"
    t.index ["group_input_id"], name: "index_inputs_on_group_input_id"
    t.index ["request_id"], name: "index_inputs_on_request_id"
  end

  create_table "machine_data", force: :cascade do |t|
    t.bigint "machine_id"
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_machine_data_on_created_at"
    t.index ["machine_id"], name: "index_machine_data_on_machine_id"
  end

  create_table "machines", force: :cascade do |t|
    t.string "title", null: false
    t.string "model", null: false
    t.string "machine_type", null: false
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "node2departs", force: :cascade do |t|
    t.bigint "node_id"
    t.bigint "department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_node2departs_on_department_id"
    t.index ["node_id"], name: "index_node2departs_on_node_id"
  end

  create_table "nodes", force: :cascade do |t|
    t.string "title"
    t.string "image"
    t.string "preview_description"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requests", force: :cascade do |t|
    t.jsonb "request"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title"
    t.string "youtube_url"
    t.bigint "machine_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["machine_id"], name: "index_reviews_on_machine_id"
  end

end
