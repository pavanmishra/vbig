class AddEventToMigration < ActiveRecord::Migration
  def self.up
    change_table :invitations do |t|
      t.column  :event_id,  :integer
    end
  end

  def self.down
    change_table :invitations do |t|
      t.remove  :event_id
    end
  end
end
