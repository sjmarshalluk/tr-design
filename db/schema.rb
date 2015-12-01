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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151112123339) do

  create_table "cities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "companies", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "name"
    t.text     "mission"
    t.text     "tech_stack"
    t.string   "hiring_saturday"
    t.string   "hiring_sunday"
    t.string   "hiring_contact"
    t.boolean  "right"
    t.integer  "founded"
    t.integer  "team_size"
    t.string   "logo"
    t.string   "saturday"
    t.string   "sunday"
    t.string   "office_postcode"
    t.integer  "pitch"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "city_id"
  end

  create_table "wayfindings", force: :cascade do |t|
    t.string   "first_content"
    t.boolean  "first_left"
    t.boolean  "first_right"
    t.string   "second_content"
    t.boolean  "second_left"
    t.boolean  "second_right"
    t.string   "third_content"
    t.boolean  "third_left"
    t.boolean  "third_right"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

end
