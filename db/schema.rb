# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100708041443) do

  create_table "categories", :force => true do |t|
    t.integer "parent_id", :default => 0
  end

  create_table "categories_products", :force => true do |t|
    t.integer "product_id",  :null => false
    t.integer "category_id", :null => false
  end

  create_table "category_names", :force => true do |t|
    t.integer "category_id",                  :null => false
    t.integer "language_id",                  :null => false
    t.string  "category_name", :limit => 100, :null => false
  end

  create_table "constant_menus", :force => true do |t|
    t.integer "language_id", :null => false
    t.text    "menu_name",   :null => false
    t.integer "sort",        :null => false
  end

  create_table "contact_us", :force => true do |t|
    t.string  "contact_name",  :limit => 100,                :null => false
    t.string  "contact_email",                               :null => false
    t.string  "contact_phone", :limit => 50,                 :null => false
    t.text    "message",                                     :null => false
    t.integer "status",                       :default => 0, :null => false
  end

  create_table "customers", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "phone"
    t.string   "address"
    t.integer  "status",                                   :default => 0
  end

  add_index "customers", ["login"], :name => "index_customers_on_login", :unique => true

  create_table "favorite_products", :force => true do |t|
    t.integer "customer_id", :null => false
    t.integer "products_id", :null => false
  end

  create_table "languages", :force => true do |t|
    t.text   "name",  :null => false
    t.string "image", :null => false
  end

  create_table "order_details", :force => true do |t|
    t.integer "order_id",                                      :null => false
    t.integer "product_id",                                    :null => false
    t.integer "final_quantity",                                :null => false
    t.decimal "final_price",    :precision => 10, :scale => 2, :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer "customer_id",                               :null => false
    t.string  "recipient",   :limit => 100,                :null => false
    t.string  "address",                                   :null => false
    t.string  "phone",       :limit => 50,                 :null => false
    t.integer "status",      :limit => 1,   :default => 0, :null => false
  end

  create_table "partners", :force => true do |t|
    t.string  "name",       :limit => 100, :null => false
    t.integer "picture_id",                :null => false
    t.string  "url",                       :null => false
  end

  create_table "pictures", :force => true do |t|
    t.string  "filename"
    t.integer "size"
  end

  create_table "product_descriptions", :force => true do |t|
    t.integer "product_id",          :null => false
    t.integer "language_id",         :null => false
    t.string  "product_name",        :null => false
    t.text    "product_description", :null => false
  end

  create_table "products", :force => true do |t|
    t.integer "picture_id",                                                             :null => false
    t.decimal "price",                    :precision => 10, :scale => 2,                :null => false
    t.integer "isnew",       :limit => 1,                                :default => 0, :null => false
    t.integer "ispromotion", :limit => 1,                                :default => 0, :null => false
    t.integer "status",      :limit => 1,                                :default => 1, :null => false
  end

end
