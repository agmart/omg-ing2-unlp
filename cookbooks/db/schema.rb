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

ActiveRecord::Schema.define(version: 20140708202337) do

  create_table "authors", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dni"
  end

  create_table "books", force: true do |t|
    t.string   "isbn"
    t.string   "titulo"
    t.integer  "paginas"
    t.decimal  "precio",          precision: 16, scale: 2
    t.integer  "ano_publicacion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "author_id"
    t.integer  "editorial_id"
    t.string   "descripcion"
    t.boolean  "habilitado",                               default: true
  end

  add_index "books", ["author_id"], name: "index_books_on_author_id", using: :btree
  add_index "books", ["editorial_id"], name: "index_books_on_editorial_id", using: :btree

  create_table "cart_books", force: true do |t|
    t.integer  "book_id"
    t.integer  "cart_id"
    t.integer  "quantity",   default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cart_books", ["book_id", "cart_id"], name: "index_cart_books_on_book_id_and_cart_id", unique: true, using: :btree

  create_table "carts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "carts", ["user_id"], name: "index_carts_on_user_id", using: :btree

  create_table "editorials", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "direccion"
  end

  create_table "purchase_book", id: false, force: true do |t|
    t.integer "purchase_id", null: false
    t.integer "book_id",     null: false
  end

  create_table "purchase_books", force: true do |t|
    t.integer  "book_id"
    t.integer  "purchase_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchases", force: true do |t|
    t.date     "fecha"
    t.string   "estado"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "total",      default: 0
  end

  add_index "purchases", ["user_id"], name: "index_purchases_on_user_id", using: :btree

  create_table "tag_book", id: false, force: true do |t|
    t.integer "tag_id",  null: false
    t.integer "book_id", null: false
  end

  create_table "tags", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "nombre"
    t.integer  "dni"
    t.date     "fecha_alta"
    t.string   "direccion"
    t.string   "tel"
    t.date     "fecha_nac"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.boolean  "es_admin"
    t.integer  "cart_id"
  end

  add_index "users", ["cart_id"], name: "index_users_on_cart_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
