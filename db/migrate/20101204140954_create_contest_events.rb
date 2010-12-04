class CreateContestEvents < ActiveRecord::Migration
  def self.up
    create_table :contest_events do |t|
      t.integer :contest_id
      t.integer :event_id

      t.timestamps
    end
  end

  def self.down
    drop_table :contest_events
  end
end
