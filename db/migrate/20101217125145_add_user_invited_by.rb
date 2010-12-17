class AddUserInvitedBy < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.integer :invited_by_id
    end
  end

  def self.down
    remove_column :users, :invited_by_id
  end
end
