class AddImageToBadge < ActiveRecord::Migration
  def self.up
    change_table :badges do |t|
      t.column :photo_file_name, :string
      t.column :photo_content_type, :string
      t.column :photo_file_size,  :integer
    end
  end

  def self.down
    remove_column :badges, :photo_file_name, :photo_content_type, :photo_file_size
  end
end
