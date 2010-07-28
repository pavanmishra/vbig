class ChangeByColumnToUserForInvitation < ActiveRecord::Migration
  def self.up
    change_table :invitations do |t|
      t.remove :by
      t.column  :user_id, :integer
    end
  end

  def self.down
    change_table :invitations do |t|
      t.remove :user_id
      t.column  :by, :integer
    end
  end
end
