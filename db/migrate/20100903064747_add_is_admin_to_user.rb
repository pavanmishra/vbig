class AddIsAdminToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.column  :is_admin,  :boolean
    end
  end

  def self.down
    remove_column :users, :is_admin
  end
end
