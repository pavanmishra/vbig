class UpdateInvitationScheme < ActiveRecord::Migration
  def self.up
    change_table  :invitations do |t|
      t.integer :contest_id
      t.integer :invitable_id
      t.string :invitable_type
    end
    remove_column :invitations, :event_id
    drop_table  :contest_invites
  end

  def self.down
    add_column  :invitations, :event_id
    remove_column :invitations, :contest_id, :invitable_id, :invitable_type
  end
end
