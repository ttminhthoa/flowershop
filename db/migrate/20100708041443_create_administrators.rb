class CreateAdministrators < ActiveRecord::Migration
  def self.up
    create_table "administrators", :force => true do |t|
      t.column :login,                     :string, :limit => 40
      t.column :name,                      :string, :limit => 100, :default => '', :null => true
      t.column :email,                     :string, :limit => 100
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
    end
    add_index :administrators, :login, :unique => true
  end

  def self.down
    drop_table "administrators"
  end
end
