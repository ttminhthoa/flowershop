class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.string :filename
      t.integer :size
    end
  end

  def self.down
    drop_table :pictures
  end
end
