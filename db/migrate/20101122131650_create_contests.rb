class CreateContests < ActiveRecord::Migration
  def self.up
    create_table :contests do |t|
      t.string :title
      t.string :description
      t.string  :address
      t.decimal  "lat",                :precision => 10, :scale => 7
      t.decimal  "lng",                :precision => 10, :scale => 7
      t.boolean  "featured"
      t.string   "image_file_name"
      t.string   "image_content_type"
      t.integer  "image_file_size"
      t.datetime "from_date"
      t.datetime "to"
      t.string   "status"      
      t.timestamps
    end
  end

  def self.down
    drop_table :contests
  end
end
