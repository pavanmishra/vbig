class ChangeUserBadgeRelation < ActiveRecord::Migration
  def self.up
    add_column :badges, :user_id, :integer
  end

  def self.down
    remove_column :badges, :user_id
  end
end
