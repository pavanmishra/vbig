class AddUserIdToComments < ActiveRecord::Migration
  def self.up
    change_table  :threaded_comments do |t|
      t.column  :user_id, :integer
    end
  end

  def self.down
    remove_column :threaded_comments, :user_id
  end
  
end
