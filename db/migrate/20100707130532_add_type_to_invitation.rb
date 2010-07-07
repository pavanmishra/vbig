class AddTypeToInvitation < ActiveRecord::Migration
  def self.up
    change_table :invitations do |t|
      t.column  :type,  :string
    end
  end

  def self.down
    change_table :invitations do |t|
      t.remove  :type
    end
  end
end
