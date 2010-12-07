class CreateContestInvites < ActiveRecord::Migration
  def self.up
    create_table :contest_invites do |t|
      t.integer :contest_id
      t.integer :invitable_id
      t.string :invitable_type
      t.string :code
      t.integer :inviter_id
      t.integer :invitee_id
      t.boolean :used, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :contest_invites
  end
end
