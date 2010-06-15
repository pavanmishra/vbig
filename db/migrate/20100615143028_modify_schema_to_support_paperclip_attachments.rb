class ModifySchemaToSupportPaperclipAttachments < ActiveRecord::Migration
  def self.up
    [:events, :users, :organizations].each do |table_name|
      change_table table_name do |t|
        t.column :image_file_name, :string
        t.column :image_content_type, :string
        t.column :image_file_size,  :integer
      end
    end
  end

  def self.down
    [:events, :users, :organizations].each do |table_name|
      change_table table_name do |t|
        t.remove  :image_file_name, :image_content_type, :image_file_size
      end
    end
  end
end
