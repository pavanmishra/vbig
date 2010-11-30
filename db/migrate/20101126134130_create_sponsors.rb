class CreateSponsors < ActiveRecord::Migration
  def self.up
    create_table :sponsors do |t|
      t.string :name
      t.text :description
      t.string   "image_file_name"
      t.string   "image_content_type"
      t.integer  "image_file_size"
      t.string  :address

      t.timestamps
    end
  end

  def self.down
    drop_table :sponsors
  end
end
