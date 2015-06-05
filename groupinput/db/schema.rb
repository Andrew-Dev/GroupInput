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

ActiveRecord::Schema.define(version: 20150529121252) do

  create_table "audiences", force: :cascade do |t|
    t.string   "title"
    t.string   "code"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "broadcast"
  end

  create_table "audiences_clients", id: false, force: :cascade do |t|
    t.integer "audience_id"
    t.integer "client_id"
  end

  create_table "broadcasts", force: :cascade do |t|
    t.integer  "audience_id"
    t.boolean  "isMultipleChoice"
    t.boolean  "isActive"
    t.text     "questionAsJSON"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string   "token"
    t.string   "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "multiple_choice_answers", force: :cascade do |t|
    t.string   "answer"
    t.integer  "multiple_choice_question_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "multiple_choice_questions", force: :cascade do |t|
    t.string   "question"
    t.boolean  "multipleAnswers"
    t.integer  "audience_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "multiple_choice_responses", force: :cascade do |t|
    t.integer  "multiple_choice_answer_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "client_id"
  end

  create_table "textquestions", force: :cascade do |t|
    t.string   "question"
    t.integer  "audience_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "textresponses", force: :cascade do |t|
    t.text     "response"
    t.string   "student"
    t.integer  "textquestion_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
